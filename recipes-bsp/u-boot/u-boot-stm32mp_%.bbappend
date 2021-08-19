FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-file-npi_commond.h-and-modify-file-stm32mp1.h-to.patch \
            file://0001-modify-_deconfig-file-CONFIG_ENV_SIZE-0x4000-so-that.patch \
            file://0001-Fix-syntax-error-BUG.patch \
            file://0001-Modify-dts-to-support-etnernet.patch \
            "

