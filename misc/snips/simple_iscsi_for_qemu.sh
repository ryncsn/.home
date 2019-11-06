iscsi_setup_server() {
    systemctl start iscsid tgtd

    tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test

    tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL

    dd if=/dev/zero of=/var/run/tgtd/iscsi-local bs=1M count=1024

    qemu-img create /var/run/tgtd/iscsi-local 1G

    # TODO: Permanent

    tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 -b /var/run/tgtd/iscsi-local --device-type=disk

    tgtadm --lld iscsi --mode logicalunit --op delete --tid 1 --lun 1

    # tgtadm --lld iscsi --mode target --op delete --tid 1

    tgtadm --lld iscsi --op show --mode target
}

iscsi_setup_client() {
    systemctl start iscsi

    iscsiadm -m discovery -t sendtargets -p 192.168.122.1

    iscsiadm --mode node --targetname iqn.qemu.test --portal 192.168.122.1 --login
}
