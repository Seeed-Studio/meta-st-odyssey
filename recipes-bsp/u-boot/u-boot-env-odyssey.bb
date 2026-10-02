SUMMARY = "Pre-built U-Boot environments selecting the Odyssey boot mode (ODYSSEY_BOOT_MODE)"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "u-boot-mkenvimage-native"
inherit deploy nopackages

SRC_URI = "file://env-net.txt file://env-emmc.txt"

# must match U-Boot's CONFIG_ENV_SIZE; the partition size is STM32MP_UENV_SIZE (KiB)
UBOOT_ENV_SIZE ?= "0x2000"
UBOOT_ENV_PARTITION_KIB = "${STM32MP_UENV_SIZE}"
# U-Boot keeps the two redundant env copies at the top of the partition
UBOOT_ENV_COPY0_OFFSET = "${@int(d.getVar('STM32MP_UENV_SIZE')) * 1024 - int(d.getVar('UBOOT_ENV_SIZE'), 16)}"
UBOOT_ENV_COPY1_OFFSET = "${@int(d.getVar('STM32MP_UENV_SIZE')) * 1024 - 2 * int(d.getVar('UBOOT_ENV_SIZE'), 16)}"

# netboot parameters (override in local.conf)
ODYSSEY_NETBOOT_SERVERIP ?= "192.168.5.1"
ODYSSEY_NETBOOT_IPADDR ?= "192.168.5.2"
ODYSSEY_NETBOOT_NETMASK ?= "255.255.255.0"
ODYSSEY_NETBOOT_NFSROOT ?= "/srv/nfs/odyssey-rootfs"

do_compile[vardeps] += "ODYSSEY_NETBOOT_SERVERIP ODYSSEY_NETBOOT_IPADDR ODYSSEY_NETBOOT_NETMASK ODYSSEY_NETBOOT_NFSROOT UBOOT_ENV_SIZE"

do_compile() {
    for mode in net emmc; do
        sed -e 's|@SERVERIP@|${ODYSSEY_NETBOOT_SERVERIP}|' -e 's|@IPADDR@|${ODYSSEY_NETBOOT_IPADDR}|' \
            -e 's|@NETMASK@|${ODYSSEY_NETBOOT_NETMASK}|' -e 's|@NFSROOT@|${ODYSSEY_NETBOOT_NFSROOT}|' \
            ${WORKDIR}/env-${mode}.txt > ${B}/env-${mode}.txt
        mkenvimage -r -s ${UBOOT_ENV_SIZE} -o ${B}/env-${mode}.img ${B}/env-${mode}.txt
        dd if=/dev/zero of=${B}/u-boot-env-${mode}.bin bs=1024 count=${UBOOT_ENV_PARTITION_KIB} status=none
        dd if=${B}/env-${mode}.img of=${B}/u-boot-env-${mode}.bin bs=1 seek=${UBOOT_ENV_COPY0_OFFSET} conv=notrunc status=none
        dd if=${B}/env-${mode}.img of=${B}/u-boot-env-${mode}.bin bs=1 seek=${UBOOT_ENV_COPY1_OFFSET} conv=notrunc status=none
    done
}

do_deploy() {
    install -d ${DEPLOYDIR}/u-boot-env
    install -m 0644 ${B}/u-boot-env-net.bin ${B}/u-boot-env-emmc.bin ${DEPLOYDIR}/u-boot-env/
}
addtask deploy after do_compile before do_build
