import os

# NOTE: make relies on Tabs for indent, sapces won't work
MAKE_PRINT_FLAGS = """
print_flags: include/config/auto.conf
	@echo "__YCM_CFLAG_HEADER__"
	@$(foreach flag, $(KBUILD_CFLAGS), echo $(flag);)
	@$(foreach flag, $(NOSTDINC_FLAGS), echo $(flag);)
	@$(foreach include, $(LINUXINCLUDE), echo $(include);)
PHONY += print_flags
"""

CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
CFLAG_CACHE = '.ycm_cflag'
LINUX_TREE_MARK = '.git'
LINUX_DIR = CURRENT_DIR

while not os.path.exists(os.path.join(LINUX_DIR, LINUX_TREE_MARK)):
    LINUX_DIR = os.path.join(LINUX_DIR, '..')

if not os.path.exists(os.path.join(LINUX_DIR, ".config")):
    raise RuntimeError('Need a valid .config or "make config" first for auto-completion to work.')

def generate_cflags_cache():
    ret = os.system('make alldefconfig')
    if ret:
        os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
        raise RuntimeError('Falied generating default config')

    ret = os.system('cd %s && make --eval \'%s\' print_flags > %s' % (LINUX_DIR, MAKE_PRINT_FLAGS, CFLAG_CACHE))
    if ret:
        os.remove(os.path.join(LINUX_DIR, CFLAG_CACHE))
        raise RuntimeError('Falied retriving C flags from Makefile')

def cflags_cache_valid():
    if not os.path.exists(os.path.join(LINUX_DIR, CFLAG_CACHE)):
        return False

    config_m = os.path.getmtime(os.path.join(LINUX_DIR, ".config"))
    cache_s = os.stat(os.path.join(LINUX_DIR, CFLAG_CACHE))

    if not cache_s.st_size:
        return False

    if cache_s.st_mtime < config_m:
        return False

    return True

def FlagsForFile(filename, **kwargs ):
    """
    Given a source file, retrieves the flags necessary for compiling it.
    """

    if not cflags_cache_valid():
        generate_cflags_cache()

    kbuild_flags = list()

    with open(CFLAG_CACHE) as cflag_cache:
        for flag in cflag_cache.readlines():
            # In case of Makefile rebuilt
            flag = flag.rstrip('\n')
            if flag == "__YCM_CFLAG_HEADER__":
                kbuild_flags.clear()
            else:
                kbuild_flags.append(flag)

    return { 'flags': list(kbuild_flags) }
