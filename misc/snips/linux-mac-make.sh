#!/bin/sh
source "$(which bee-init)"
# KBUILD_HOSTLDFLAGS is a workaround for 27758d8c2583
HOSTCFLAGS="$HOSTCFLAGS -DO_LARGEFILE=0 -include /Users/kasong/.home/misc/include/wrapper.h" make LLVM=1 KBUILD_HOSTLDFLAGS="" "$@"
