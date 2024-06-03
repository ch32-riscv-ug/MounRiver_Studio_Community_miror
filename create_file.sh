#!/bin/bash

var=1.91

basedir=$(cd $(dirname $0); pwd)
cd $basedir

rm -rfv file
mkdir file

#######################################################################################################
# Windows
#######################################################################################################
wget --continue https://github.com/ch32-riscv-ug/MounRiver_Studio_Community_miror/releases/download/${var}-toolchain/MRS_Toolchain_Win_V${var}.zip

unzip MRS_Toolchain_Win_V${var}.zip

cd MRS_Toolchain_Win_V${var}/

# beforeinstall
mkdir beforeinstall-win-${var}
touch beforeinstall-win-${var}/dummy.txt
zip -r beforeinstall-win-${var}.zip beforeinstall-win-${var}

# OpenOCD
mv OpenOCD openocd-win-${var}
zip -r openocd-win-${var}.zip openocd-win-${var}

# gcc8
mv "RISC-V Embedded GCC" riscv-none-embed-gcc-8-win-${var}
zip -r riscv-none-embed-gcc-8-win-${var}.zip riscv-none-embed-gcc-8-win-${var}

# gcc12
mv "RISC-V Embedded GCC12" riscv-none-elf-gcc-12-win-${var}
zip -r riscv-none-elf-gcc-12-win-${var}.zip riscv-none-elf-gcc-12-win-${var}

mv *.zip ${basedir}/file

cd ${basedir}

#######################################################################################################
# Linux
#######################################################################################################
wget --continue https://github.com/ch32-riscv-ug/MounRiver_Studio_Community_miror/releases/download/${var}-toolchain/MRS_Toolchain_Linux_x64_V${var}.tar.xz

tar Jxvf MRS_Toolchain_Linux_x64_V${var}.tar.xz

cd MRS_Toolchain_Linux_x64_V${var}/

# beforeinstall
mv beforeinstall/start.sh beforeinstall/post_install.sh
mv beforeinstall beforeinstall-linux-${var}
zip -r beforeinstall-linux-${var}.zip beforeinstall-linux-${var}

# OpenOCD
mv OpenOCD openocd-linux-${var}
zip -r openocd-linux-${var}.zip openocd-linux-${var}

# gcc8
mv RISC-V_Embedded_GCC riscv-none-embed-gcc-8-linux-${var}
zip -r riscv-none-embed-gcc-8-linux-${var}.zip riscv-none-embed-gcc-8-linux-${var}

# gcc12
mv RISC-V_Embedded_GCC12 riscv-none-elf-gcc-12-linux-${var}
zip -r riscv-none-elf-gcc-12-linux-${var}.zip riscv-none-elf-gcc-12-linux-${var}

mv *.zip ${basedir}/file

cd ${basedir}

#######################################################################################################
# Mac
#######################################################################################################
wget --continue https://github.com/ch32-riscv-ug/MounRiver_Studio_Community_miror/releases/download/${var}-toolchain/MRS_Toolchain_Mac_V${var//\./}.zip

unzip MRS_Toolchain_Mac_V${var//\./}.zip -d MRS_Toolchain_Mac

cd MRS_Toolchain_Mac/

# beforeinstall
mkdir beforeinstall-mac-${var}
touch beforeinstall-mac-${var}/dummy.txt
zip -r beforeinstall-mac-${var}.zip beforeinstall-mac-${var}

# OpenOCD
mv openocd_arm64 openocd-mac-arm64-${var}
zip -r openocd-mac-arm64-${var}.zip openocd-mac-arm64-${var}
mv openocd_x86_64 openocd-mac-x86_64-${var}
zip -r openocd-mac-x86_64-${var}.zip openocd-mac-x86_64-${var}

mv *.zip ${basedir}/file

## MRS_Toolchain_MAC_V*.pkg

unar MRS_Toolchain_MAC_V*.pkg
cd MRS_Toolchain_MAC_V*/
cd MRS_Toolchain_MAC.pkg/
cat Payload | gunzip -dc |cpio -i
cd Users
cd Shared
cd MRS_Toolchain_MAC_V*/

# gcc8
cp ${basedir}/file/riscv-none-embed-gcc-8-linux* .
unzip riscv-none-embed-gcc-8-linux*.zip
unzip xpack-riscv-none-*-8*.zip
rm -rfv riscv-none-embed-gcc-8-linux*.zip
rm -rfv xpack-riscv-none-*-8*.zip

find ./riscv-none-*-8-*/riscv-none-*/lib/ -type f | grep -v -E 'libprintf' | xargs rm -rfv
find ./riscv-none-*-8-*/riscv-none-*/lib/ -type d -empty -delete
cp -rfvp ./riscv-none-*-8-*/riscv-none-*/lib/* xpack-riscv-none-embed-gcc*/riscv-none-*/lib/
mv xpack-riscv-none-embed-gcc-8*/ riscv-none-embed-gcc-8-mac-${var}
zip -r riscv-none-embed-gcc-8-mac-${var}.zip riscv-none-embed-gcc-8-mac-${var}/

# gcc12
mv xpack-riscv-none-elf-gcc-12*.zip riscv-none-elf-gcc-12-mac-${var}.zip

mv *.zip ${basedir}/file

cd ${basedir}

#######################################################################################################

rm -rfv MRS_Toolchain*
