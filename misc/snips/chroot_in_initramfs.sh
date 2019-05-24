chroot_init() {
    # systemctl start dracut-initqueue.service
    # systemctl start sysroot.mount

    mount --bind /proc/ /$1/proc/
    mount --bind /tmp/ /$1/tmp/
    mount --bind /sys/ /$1/sys/
    mount --bind /dev/ /$1/dev/
    mount --bind /dev/pts /$1/dev/pts

    chroot $@
}
