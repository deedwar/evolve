cp ./arch/arm/configs/opensemc_fuji_hikari_row_defconfig .config
ARCH=arm CROSS_COMPILE=~/github/gcc/linaro-4.7/bin/arm-eabi- make -j8 menuconfig
ARCH=arm CROSS_COMPILE=~/github/gcc/linaro-4.7/bin/arm-eabi- make -j8
