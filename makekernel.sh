#!/bin/bash

# Add Colors to unhappiness
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

clear

# Pure Kernel Version
BASE_AK_VER="evolve"
VER="-1.23"
AK_VER=$BASE_AK_VER$VER

# AK Variables
export LOCALVERSION="~"`echo $AK_VER`
export CROSS_COMPILE=~/github/gcc/arm-cortex_a8-linux-gnueabi-linaro_4.7.4-2014.04/bin/arm-cortex_a8-linux-gnueabi-
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER=deedwar
export KBUILD_BUILD_HOST="kernel"

DATE_START=$(date +"%s")

echo
echo -e "${green}"
echo "deedwar Kernel Creation Script:"
echo -e "${restore}"
echo

echo -e "${green}"
echo "------------------------"
echo "Show: Kernel Settings"
echo "------------------------"
echo -e "${restore}"

MODULES_DIR=${HOME}/kernel/pure/cwm/system/lib/modules
KERNEL_DIR=`pwd`
OUTPUT_DIR=${HOME}/kernel/evolve-1x
CWM_DIR=${HOME}/kernel/evolve-1x/cwm
ZIMAGE_DIR=${HOME}/github/kernel/evolve-1x/arch/arm/boot
CWM_MOVE=${HOME}/kernel/evolve-1x
BOOT_IMG=${HOME}/kernel/evolve-1x/boot
ZIMAGE_ANYKERNEL=${HOME}/kernel/evolve-1x/cwm
ANYKERNEL_DIR=${HOME}/kernel/evolve-1x

echo -e "${red}"; echo "COMPILING VERSION:"; echo -e "${blink_red}"; echo "$LOCALVERSION"; echo -e "${restore}"
echo "CROSS_COMPILE="$CROSS_COMPILE
echo "ARCH="$ARCH
echo "MODULES_DIR="$MODULES_DIR
echo "KERNEL_DIR="$KERNEL_DIR
echo "OUTPUT_DIR="$OUTPUT_DIR
echo "CWM_DIR="$CWM_DIR
echo "ZIMAGE_DIR="$ZIMAGE_DIR
echo "CWM_MOVE="$CWM_MOVE
echo "ZIMAGE_ANYKERNEL="$ZIMAGE_ANYKERNEL
echo "ANYKERNEL_DIR="$ANYKERNEL_DIR

echo -e "${green}"
echo "-------------------------"
echo "Making: Evolve Defconfig"
echo "-------------------------"
echo -e "${restore}"

make "opensemc_fuji_hikari_row_defconfig"
make -j8

echo -e "${green}"
echo "--------------------------"
echo "Copy: Modules to direcroty"
echo "--------------------------"
echo -e "${restore}"

rm `echo $MODULES_DIR"/*"`
find $KERNEL_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
echo

echo -e "${green}"
echo "----------------------------"
echo "Create: Zip and moving files"
echo "----------------------------"
echo -e "${restore}"
cp -vr $ZIMAGE_DIR/zImage $BOOT_IMG
cd $BOOT_IMG
python ./tools/mkelf.py -o ./boot.img ./zImage@0x40208000 ./tools/combinedroot.fs@0x41500000,ramdisk ./tools/RPM.bin@0x20000,rpm
cp -vr $BOOT_IMG/boot.img $ZIMAGE_ANYKERNEL
echo

cd $CWM_DIR
zip -r `echo $AK_VER`.zip *
mv  `echo $AK_VER`.zip $OUTPUT_DIR

echo -e "${green}"
echo "-------------------------"
echo "The End: Evolve is Born"
echo "-------------------------"
echo -e "${restore}"

cp -vr $OUTPUT_DIR/`echo $AK_VER`.zip ~/kernel/
cp -vr $OUTPUT_DIR/ boot.img ~/kernel/
echo

cd $ANYKERNEL_DIR
git reset --hard
git clean -f
rm -f ./cwm/system/lib/modules/*
rm -f ./cwm/boot.img
echo

cd $KERNEL_DIR

echo -e "${green}"
echo "-------------------------"
echo "Build Completed in:"
echo "-------------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

