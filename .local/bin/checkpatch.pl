#!/usr/bin/env sh
# Ha, it's a shell script

TOPDIR=$(git rev-parse --show-toplevel 2>/dev/null)
[ -z $TOPDIR ] && exit 0
[ ! -e $TOPDIR/scripts/checkpatch.pl ] && exit 0
exec $TOPDIR/scripts/checkpatch.pl "$@"
