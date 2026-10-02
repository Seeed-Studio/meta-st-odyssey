# U-Boot only derives ${fdtfile} for "st," compatibles; this board's is "seeed,...", so
# extlinux.conf has to name the devicetree explicitly or Linux is never started.
UBOOT_EXTLINUX_FDT = "/stm32mp157c-odyssey.dtb"
