# Shrink the sdcard flash layout (rootfs slot 1.75 GiB). Set from anonymous python because the
# flashlayout class re-expands this key after normal assignments and would clobber the value.
python () {
    d.setVar('FLASHLAYOUT_PARTITION_SIZE:sdcard:rootfs', '1835008')
}
