cp ~/dev/evolve/arch/arm/boot/zImage ~/dev/ramdisk
cd ..
cd ramdisk
python mkelf.py -o kernel.elf zImage@0x40208000 ramdisk.img@0x41500000,ramdisk RPM.bin@0x20000,rpm
