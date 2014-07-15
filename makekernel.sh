cp ./arch/arm/configs/opensemc_fuji_hikari_row_defconfig .config
ARCH=arm CROSS_COMPILE=~/github/gcc/arm-cortex_a8-linux-gnueabi-linaro_4.7.4-2014.04/bin/arm-cortex_a8-linux-gnueabi- make -j8 menuconfig
ARCH=arm CROSS_COMPILE=~/github/gcc/arm-cortex_a8-linux-gnueabi-linaro_4.7.4-2014.04/bin/arm-cortex_a8-linux-gnueabi- make -j8
