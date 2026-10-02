FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# ST's scarthgap TF-A already carries the Odyssey devicetrees (incl. the I2C2 PMIC); only the
# PLL4 fix remains: VCO 594 -> 750 MHz so PLL4_P provides the KSZ9031's 125 MHz RGMII clock.
SRC_URI += "file://0002-fix-change-VCO-from-594MHz-to-750MHz-for-eth-phy.patch"
