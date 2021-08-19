This README file contains information on the contents of the meta-st-odyssey layer.

Please see the corresponding sections below for details.



How to use: 
============
* Method one:
  1. $ repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-5.10-dunfell-mp1-21-03-31
  2. $ repo sync
  3. $ git clone git@github.com:Seeed-Studio/meta-st-odyssey.git
  4. $ DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh
  5. $ bitbake-layers add-layer ../meta-st-odyssey
  6. $ bitbake st-image-weston


