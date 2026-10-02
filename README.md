# meta-st-odyssey

OpenSTLinux scarthgap (Yocto 5.0, kernel 6.6, OP-TEE 4.0) board support for the
Seeed Studio Odyssey-STM32MP157C, on the standard OpenSTLinux secure boot flow
(TF-A → OP-TEE → U-Boot → Linux).

## 1. Clone repositories

```bash
git clone https://gerrit.googlesource.com/git-repo
./git-repo/repo init -u https://github.com/n35tef/oe-manifest-odyssey.git -b scarthgap
./git-repo/repo sync
```

## 2. Set env

```bash
export READTIMEOUT=0; DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh --pkg-update --no-ui
```

## 3. Add meta-st-odyssey layer

```bash
bitbake-layers add-layer ../meta-st-odyssey
```

## 4. Build project

```bash
bitbake st-image-weston
```

## 5. Make and flash the SD card image

```bash
cd tmp-glibc/deploy/images/stm32mp1
./scripts/create_sdcard_from_flashlayout.sh flashlayout_st-image-weston/optee/FlashLayout_sdcard_stm32mp157c-odyssey-optee.tsv
sudo dd if=FlashLayout_sdcard_stm32mp157c-odyssey-optee.raw of=/dev/sdX bs=8M status=progress conv=fsync
```

Set the boot switches to SD card and power on; the console is on the USB-C
debug port (`ttyUSB0`, 115200 8N1).

## 6. Boot mode (optional)

The image's `u-boot-env` partition selects how U-Boot boots; set
`ODYSSEY_BOOT_MODE` in `local.conf` before step 4 and build one image per mode:

| `ODYSSEY_BOOT_MODE` | U-Boot behaviour |
|---|---|
| `sdcard` (default) | stock: boots the system on the SD card |
| `emmc` | boots the system installed on the eMMC (`boot_targets=mmc1`) |
| `net` | TFTP `zImage` + `stm32mp157c-odyssey.dtb`, NFSv3 root — used to validate this layer |

For `net`, serve `tmp-glibc/deploy/images/stm32mp1/kernel/{zImage,stm32mp157c-odyssey.dtb}`
over TFTP and the extracted `st-image-weston-...rootfs.tar.xz` over NFSv3; the
defaults (server `192.168.5.1`, board `192.168.5.2`, export `/srv/nfs/odyssey-rootfs`)
are `ODYSSEY_NETBOOT_*` variables in `recipes-bsp/u-boot/u-boot-env-odyssey.bb`,
overridable in `local.conf`.

## What changed vs. the mickledore branch

| Component | mickledore (6.1) | scarthgap (6.6) |
|---|---|---|
| TF-A | board DT + I2C2 PMIC patch, PLL4 VCO patch | ST's TF-A now carries the board DTs; only the PLL4 VCO patch is kept (unchanged) |
| OP-TEE | 1200-line DK2-derived DT, PMIC-on-I2C2 patch, VCO patch | one patch: Odyssey DT (DK2 SoM, PMIC on I2C2), I2C2 as non-secure clock, 512M flavor |
| U-Boot | board support patch, VCO patch | board support is in ST's U-Boot; new: OP-TEE TEE client node (BSEC/MAC), Ethernet fixes (PHY addr, reset GPIO, eth-clk-sel, rgmii, KSZ9031 driver). The VCO patch was dead code (SPL-only path, no SPL in this flow) |
| Kernel | bootup fix, VCO/eth-phy rework, USB host patch | SCMI overlay for the OP-TEE flow, Ethernet (MAC-level PHY reset, rgmii), USB host (incl. PHY supplies), WiFi/BT (new: SDIO, BT UART, RTC 32 kHz clock) |
| Firmware | – | AP6236 WiFi/BT firmware, nvram and BT patchram from Seeed's factory image |
| Images | – | sdcard flash layout shrunk to fit a 2 GB card |
| conf | – | Odyssey-only devicetree build, extlinux names the dtb explicitly (U-Boot can't derive it for non-`st,` compatibles) |

## What's in here

| Path | Purpose |
|---|---|
| `recipes-bsp/trusted-firmware-a/` | PLL4 VCO fix for the Ethernet PHY clock |
| `recipes-bsp/u-boot/` | OP-TEE TEE client node, Ethernet fixes, extlinux dtb name |
| `recipes-security/optee/` | Odyssey OP-TEE devicetree (STPMIC1 on I2C2) |
| `recipes-kernel/linux/` | SCMI overlay, Ethernet, USB host, WiFi/BT devicetree patches, btusb config |
| `recipes-kernel/linux-firmware/` | AP6236 firmware/nvram/patchram |
| `recipes-st/images/` | sdcard flash layout size |
