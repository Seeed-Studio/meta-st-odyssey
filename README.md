This README file contains information on the contents of the meta-st-odyssey layer.

Please see the corresponding sections below for details.



How to build:
============
* Method One:
  1. $ repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-5.10-dunfell-mp1-21-03-31
  2. $ repo sync
  3. $ git clone https://github.com/Seeed-Studio/meta-st-odyssey.git
  4. $ DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh
  5. $ bitbake-layers add-layer ../meta-st-odyssey
  6. $ bitbake st-image-weston

How to burn:
* Operate with linux
    1. After build successfully,
    2. Plug in sd card by SD-reader
    3. Ensure that sd card has been mounted on Linux system
        + like:
          ```sh
            $ ls /dev/sd*
          ```
        + such as mine:
          ```sh
            $ ls /dev/sdb*  #(/dev/sdb is sd card in my linux system)
          ```
    4. Erase the sd card partition information
        ```sh
          $ sudo dd if=/dev/zero of=/dev/sdb bs=1M count=10
        ```
    5. Create a new information partition information table
        ```sh
            $ sudo sgdisk -o /dev/sdb
            $ sudo sgdisk --resize-table=128 -a 1 \
                              -n 1:34:545      -c 1:fsbl1   \
                              -n 2:546:1057    -c 2:fsbl2   \
                              -n 3:1058:5153   -c 3:fip    \
                              -n 4:5154:136225 -c 4:bootfs    \
                              -n 5:136226:     -c 5:rootfs  \
                              -p /dev/sdb
            $ sudo sgdisk -A 4:set:2 /dev/sdb
        ```
    6. burn tf-a,fip firmware
        ```sh
          $ cd <st-yocto pro dir>/<build dir>/tmp-glibc/deploy/image/stm32mp1/
          $ sudo dd if=arm-trusted-firmware/tf-a-stm32mp157c-odyssey-sdcard.stm32  of=$/dev/sdb1
          $ sudo dd if=arm-trusted-firmware/tf-a-stm32mp157c-odyssey-sdcard.stm32  of=$/dev/sdb2
          $ sudo dd if=fip/fip-stm32mp157c-odyssey-trusted.bin  of=$/dev/sdb3
        ```
    7. burn bootfs,rootfs
        ```sh
          $ sudo mkfs.ext4 -L bootfs /dev/sdb4
          $ sudo mkfs.ext4 -L rootfs /dev/sdb5

          $ sudo mkdir -p /media/boot/
          $ sudo mkdir -p /media/rootfs/

          $ sudo mount /dev/sdb4 /media/boot/
          $ sudo mount /dev/sdb5 /media/rootfs/

          $ export kernel_version=5.10.10-stm32-r1
          $ sudo cp kernel/stm32mp157c-odyssey.dtb /media/boot/dtbs/${kernel_version}/
          $ sudo cp kernel/zImage /media/boot/
          $ sudo sh -c "echo 'uname_r=${kernel_version}' >> /media/boot/uEnv.txt"
          $ sudo sh -c "echo 'dtb=stm32mp157c-odyssey.dtb' >> /media/boot/uEnv.txt"
          $ mkdir -p rootfs_mount
          $ sudo  mount st-image-weston-openstlinux-weston-stm32mp1.ext4 rootfs_mount/
          $ sudo cp -rf rootfs_mount/*  /media/rootfs/
          $ sync
          $ sudo umount /media/boot/ /media/rootfs/
          $ sudo umount rootfs_mount
        ```



