# artik-tizen
Samsung Artik &amp; Tizen OS related stuff

## artik_tizen_zypper_install.sh

This small and simple script downloads and installs the packages needed to install Zypper package manager onto a newly installed Tizen OS on Samsung Artik computer. It will save you some minutes so that you don't need to restore the dependencies tree for Zypper by yourself.

### Detailed description

This script downloads and installs the packages needed to install Zypper package manager onto a newly installed Tizen OS.
The target computer is Samsung Artik (tested on 7 & 10) with Tizen v.3.0.
It should be run on host PC with Linux, which is connected to the Internet and connected to Artik computer via LAN
All the necessary packages weigh about 3 Mb total.

Before running this script, you should do:
sdb connect IP_ADDRESS
where IP_ADDRESS is Artik's address in LAN (can be found using ifconfig on Artik)
After launching the script, you do "zypper update"
Then you can simply "zypper install" package name. It will install any package from the repo with all dependencies.

sdb is a utility which helps to connect to Tizen device in a SSH-like way. It installs automatically together with Tizen Studio
