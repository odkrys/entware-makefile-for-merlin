# entware-makefile-for-merlin

Entware buildroot

apt-get install git-core git build-essential libssl-dev libncurses5-dev unzip gawk zlib1g-dev subversion mercurial gettext file python rsync


useradd -d /USERNAME -m -s /bin/bash USERNAME

passwd USERNAME

nano /etc/sudoers

```
# Allow members of group sudo to execute any command
%sudo ALL=(ALL:ALL) ALL
USERNAME ALL=(ALL) ALL
```

chmod u-w /etc/sudoers

su - USERNAME

cd /USERNAME
git clone https://github.com/Entware/Entware.git

cd Entware
cp configs/aarch64-3.10.config .config

make package/symlinks

make tools/install
make toolchain/install
make target/compile

ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

Make Makefile
```
/USERNAME/Entware/feeds/packages/net/wireguard-kernel
```
Make symlink
```
ln -s /USERNAME/Entware/feeds/packages/net/wireguard-kernel /USERNAME/Entware/package/feeds/packages
```

Run Make oldconfig and choose M as modular.

make package/wireguard-kernel/compile V=s

The package will be generated in /USERNAME/Entware/bin/targets/aarch64-3.10/generic-glibc/packages
