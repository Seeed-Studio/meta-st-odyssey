FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# 0001  OP-TEE TEE client node: without it BSEC (MAC address from OTP) falls back to raw SMC and fails
# 0002  Ethernet: PHY at MDIO 7, reset GPIO (driver support added), st,eth-clk-sel, rgmii,
#       KSZ9031 PHY driver in the defconfig
SRC_URI += " \
    file://0001-ARM-dts-stm32mp157c-odyssey-add-optee-tee-client-node.patch \
    file://0002-stm32mp157c-odyssey-ethernet.patch \
"
