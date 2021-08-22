FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://${LINUX_VERSION}/${LINUX_VERSION}.${LINUX_SUBVERSION}/0001-Modify-.dts-file-so-that-make-the-kernel-run-normall.patch \
            file://${LINUX_VERSION}/${LINUX_VERSION}.${LINUX_SUBVERSION}/0001-Modify-files-to-make-raspberrypi-touchscreen-run-on-.patch \
            file://${LINUX_VERSION}/fragment-06-raspberrypi-touchscreen.config;subdir=fragments \
            "

# Add custom macro to .config
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/fragments/${LINUX_VERSION}/fragment-06-raspberrypi-touchscreen.config"

# Don't forget to add/del for devupstream
SRC_URI_class-devupstream += "file://${LINUX_VERSION}/fragment-06-raspberrypi-touchscreen.config;subdir=fragments"
