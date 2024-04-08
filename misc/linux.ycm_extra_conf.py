#!/usr/bin/env python3
import os

# NOTE: Makefile relies on Tabs for indent, sapces won't work
MAKEFILE_YCM = """
print_flags: include/config/auto.conf
	@echo "__YCM_CFLAG_HEADER__"
	@$(foreach flag, $(KBUILD_CFLAGS), echo $(flag);)
	@$(foreach flag, $(NOSTDINC_FLAGS), echo $(flag);)
	@$(foreach include, $(LINUXINCLUDE), echo $(include);)
PHONY += print_flags
"""

def DirectoryOfThisScript():
    return os.path.dirname(os.path.abspath(__file__))

CFLAG_CACHE = '.ycm_cflag'
LINUX_TREE_MARK = '.git'
LINUX_DIR = DirectoryOfThisScript()

while not os.path.exists(os.path.join(LINUX_DIR, LINUX_TREE_MARK)):
    LINUX_DIR = os.path.join(LINUX_DIR, '..')

if not os.path.exists(os.path.join(LINUX_DIR, ".config")):
    raise RuntimeError('Need a valid .config or "make config" first for auto-completion to work.')

def __generate_cflags_cache():
    arch_param=""

    # Get arch from .config
    with open(".config") as config:
        for line in config:
            if line[0] not in " #\t":
                break
            keys = line.replace("/", " ").split()
            for i, key in enumerate(keys):
                if key == "Linux":
                    if i + 1 < len(keys):
                        arch_param = "ARCH=" + keys[i + 1]
                        break

    with open("Makefile", "r") as makefile:
        with open("Makefile.ycm", "w") as file:
            line = makefile.readline()
            while line:
                file.write(line)
                if line.startswith("NAME ="):
                    file.write(MAKEFILE_YCM)
                line = makefile.readline()

    # I haven't found a better way to add a new target to Makefile...
    os.system("cd %s && mv Makefile Makefile.ycm_bak" % LINUX_DIR)
    cmdline = 'cd %s && mv Makefile.ycm Makefile && make CROSS_COMPILE="scripts/dummy-tools/" %s print_flags > %s' % (LINUX_DIR, arch_param, CFLAG_CACHE)
    os.system("cd %s && mv Makefile.ycm_bak Makefile" % LINUX_DIR)
    ret = os.system(cmdline)
    if ret:
        os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
        raise RuntimeError('Failed calling "%s"' % cmdline)

    cmdline = 'cd %s && make CROSS_COMPILE="scripts/dummy-tools/" %s headers' % (LINUX_DIR, arch_param)
    ret = os.system(cmdline)
    if ret:
        os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
        raise RuntimeError('Failed calling "%s"' % cmdline)

    # Prepare dynamic include headers as much as possible, with a few missing headers (due to dependency or toolchain limitation) auto complete can still work.
    cmdline = 'cd %s && yes '' | make -i CROSS_COMPILE="scripts/dummy-tools/" %s prepare' % (LINUX_DIR, arch_param)
    ret = os.system(cmdline)
    if ret:
        os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
        raise RuntimeError('Failed calling "%s"' % cmdline)

def __cflags_cache_valid():
    if not os.path.exists(os.path.join(LINUX_DIR, CFLAG_CACHE)):
        return False

    config_m = os.path.getmtime(os.path.join(LINUX_DIR, ".config"))
    cache_s = os.stat(os.path.join(LINUX_DIR, CFLAG_CACHE))

    if not cache_s.st_size:
        return False

    if cache_s.st_mtime < config_m:
        return False

    return True

def __get_flags(filename):
    if not __cflags_cache_valid():
        __generate_cflags_cache()

    kbuild_flags=[
        '-lm',
        "-Dsection(x)=",
        "-D__section__(x)=",
        "-Dlikely(x)=x",
        "-Dunlikely(x)=x",
        "-Dlikely_notrace(x)=x",
        "-Dunlikely_notrace(x)=x",
        "-DEXPORT_SYMBOL_GPL(x)=",
        "-DEXPORT_SYMBOL(x)=",
        "-Dbarrier(x)=",
        "-DRELOC_HIDE(x, y)=(x + y)",
    ]

    with open(CFLAG_CACHE) as cflag_cache:
        for flag in cflag_cache.readlines():
            # In case of Makefile rebuilt
            flag = flag.rstrip('\n')
            if flag == "__YCM_CFLAG_HEADER__":
                continue
            if flag.startswith("-mabi="):
                continue
            if flag in ["-fno-allow-store-data-races", "-fconserve-stack"]:
                continue
            kbuild_flags.append(flag)

    kbuild_flags += [
        '-Iarch/dummy/include',
    ]

    return kbuild_flags

# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def Settings(filename=None, **kwargs):
    return {
        'flags': __get_flags(filename),
        'include_paths_relative_to_dir': DirectoryOfThisScript()
    }
