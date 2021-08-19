FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-stm32mp157c-odyssey.dts-file-to-support-tf-a-fir.patch \
            file://0001-Add-i2c2_pins_a-to-support-stm32mp157c-odyssey.patch \
            "

