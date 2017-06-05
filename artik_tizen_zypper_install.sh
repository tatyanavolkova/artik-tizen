#!/usr/bin/env bash  
#title          :artik_tizen_zypper_install.sh
#description    :This script installs deps for Zypper package manager in Tizen on Artik
#author         :Tatyana Volkova (volkova.t@samsung.com)
#date           :20170605
#version        :0.1    
#usage          :./artik_tizen_zypper_install.sh
#notes          :       
#bash_version   :4.3.48(1)-release
#============================================================================

# This script downloads and installs the packages needed to install Zypper package manager onto a newly installed Tizen OS.
# The target computer is Samsung Artik (tested on 7 & 10) with Tizen v.3.0.
# It should be run on host PC with Linux, which is connected to the Internet and connected to Artik computer via LAN
# All the necessary packages weigh about 3 Mb total.
#
# Before running this script, you should do:
# sdb connect IP_ADDRESS
# where IP_ADDRESS is Artik's address in LAN (can be found using ifconfig on Artik)
# After launching the script, you do "zypper update"
# Then you can simply "zypper install" package name. It will install any package from the repo with all dependencies.


sdb root on

echo -e "\n\nDownloading packages to install zypper\n"

wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/3.0.m2-base/latest/repos/arm/packages/armv7l/bzip2-1.0.6-1.5.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/libsolv-0.6.4-3.4.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/libsolv-tools-0.6.4-3.4.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/pacrunner-0.7-3.5.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/pacrunner-libproxy-0.7-3.5.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/lsof-4.87-3.3.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/libzypp-14.27.0-3.6.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/libaugeas-1.3.0-3.6.armv7l.rpm
wget https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages/armv7l/zypper-1.11.11-3.5.armv7l.rpm

echo -e "\n\nUploading packages to Artik\n"

sdb shell mkdir -p /tmp/packages
sdb push *.rpm /tmp/packages/

echo -e "\n\Installing packages\n"

#install every required package
sdb shell rpm -Uvh /tmp/packages/bzip2-1.0.6-1.5.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/libsolv-0.6.4-3.4.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/libsolv-tools-0.6.4-3.4.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/pacrunner-0.7-3.5.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/pacrunner-libproxy-0.7-3.5.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/lsof-4.87-3.3.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/libzypp-14.27.0-3.6.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/libaugeas-1.3.0-3.6.armv7l.rpm
sdb shell rpm -Uvh /tmp/packages/zypper-1.11.11-3.5.armv7l.rpm

echo -e "\n\Setting up repositories location\n"

#after installing zypper we should tell him the path to repositories
sdb shell zypper ar https://download.tizen.org/releases/milestone/tizen/3.0.m2/3.0.m2-base/latest/repos/arm/packages Base
sdb shell zypper ar https://download.tizen.org/releases/milestone/tizen/3.0.m2/common_artik/latest/repos/arm-wayland/packages Common

#delete all unnecessary packets from target pc
echo -e "\n\Removing rpms from target pc\n"
sdb shell rm -rf /tmp/packages

#delete all unnecessary packets from target pc
echo -e "\n\Removing rpms from target pc\n"
rm *.rpm
