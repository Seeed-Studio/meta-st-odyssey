FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# AP6236 = BCM43430 B0: brcmfmac requests brcmfmac43430b0-sdio, which the base recipe's
# Murata A1 blob never matches. Firmware, nvram and BT patchram are Seeed's factory files.
SRC_URI += " \
    file://brcmfmac43430b0-odyssey.bin \
    file://nvram_ap6236-odyssey.txt \
    file://BCM43430B0-odyssey.hcd \
"

do_install:append:stm32mp1common() {
    install -m 0644 ${WORKDIR}/brcmfmac43430b0-odyssey.bin ${D}${nonarch_base_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/nvram_ap6236-odyssey.txt ${D}${nonarch_base_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/BCM43430B0-odyssey.hcd ${D}${nonarch_base_libdir}/firmware/brcm/

    cd ${D}${nonarch_base_libdir}/firmware/brcm/
    # generic names plus the "<fw>.<machine compatible>" names brcmfmac/btbcm try first
    ln -sf brcmfmac43430b0-odyssey.bin brcmfmac43430b0-sdio.bin
    ln -sf brcmfmac43430b0-odyssey.bin brcmfmac43430b0-sdio.seeed,stm32mp157c-odyssey.bin
    ln -sf nvram_ap6236-odyssey.txt brcmfmac43430b0-sdio.txt
    ln -sf nvram_ap6236-odyssey.txt brcmfmac43430b0-sdio.seeed,stm32mp157c-odyssey.txt
    ln -sf BCM43430B0-odyssey.hcd BCM43430B0.hcd
    ln -sf BCM43430B0-odyssey.hcd BCM.seeed,stm32mp157c-odyssey.hcd
}
