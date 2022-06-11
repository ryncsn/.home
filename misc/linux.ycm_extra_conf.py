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
    arch=None

    # Get arch from .config
    with open(".config") as config:
        for line in config:
            if line[0] not in " #\t":
                break
            keys = line.replace("/", " ").split()
            for i, key in enumerate(keys):
                if key == "Linux":
                    if i + 1 < len(keys):
                        arch = keys[i + 1]
                        break

    cmdline = 'cd %s && cp Makefile Makefile.ycm' % (LINUX_DIR)
    ret = os.system(cmdline)
    if ret:
        raise RuntimeError('Failed calling "%s"' % cmdline)

    try:
        with open("Makefile", "a") as file:
            file.write(MAKEFILE_YCM)

        cmdline = 'cd %s && make CROSS_COMPILE="scripts/dummy-tools/" ARCH="%s" -f Makefile.ycm print_flags > %s' % (LINUX_DIR, arch, CFLAG_CACHE)
        ret = os.system(cmdline)
        if ret:
            os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
            raise RuntimeError('Failed calling "%s"' % cmdline)
    finally:
        os.system('cd %s && mv Makefile.ycm Makefile' % (LINUX_DIR))

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

def __get_flags():
    if not __cflags_cache_valid():
        __generate_cflags_cache()

    kbuild_flags=[
        '-I./tools/include/uapi',
        '-include',
        './include/linux/types.h',
        '-include',
        './include/asm-generic/int-ll64.h',
        '-include',
        './include/linux/sched.h',
    ]

    with open(CFLAG_CACHE) as cflag_cache:
        for flag in cflag_cache.readlines():
            # In case of Makefile rebuilt
            flag = flag.rstrip('\n')
            if flag == "__YCM_CFLAG_HEADER__":
                continue
            elif flag.startswith("-f"):
                continue
            elif flag.startswith("-m"):
                continue
            else:
                kbuild_flags.append(flag)

    return kbuild_flags

# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def Settings( **kwargs ):
    return {
        'flags': __get_flags(),
        'include_paths_relative_to_dir': DirectoryOfThisScript()
    }

print(__get_flags())
