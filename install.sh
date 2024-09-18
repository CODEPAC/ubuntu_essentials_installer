#!/bin/bash
apt update
packages=(vim git curl htop libreoffice)
echo -e "the following packages will be installed\n"
echo $packages

for package in "${packages[@]}"; do 
    echo "installing $package ....."
    apt install  -oDebug::pkgAcquire::Worker=1  -y -f "$package"
done
# iNSTALL  dropbox
current="$(pwd)"
URL="https://linux.dropbox.com/packages/ubuntu/dropbox_2024.04.17_amd64.deb" 
OUT_URL="/tmp/dropbox.deb"
echo "donwlaoding "
echo $URL 
echo "to "
echo $OUT_URL
curl $URL --output $OUT_URL
yes | dpkg -i $OUT_URL
echo "finished installing dropbox, deleting installer"
rm $OUT_URL

# installing OMyZs
echo "installing zsh"
apt install zsh
OMyZs_OUT="./omyzsh_installer.sh"
curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" -o $OMyZs_OUT
echo "installing oh my zsh"
chmod a+x $OMyZs_OUT
sh -c $OMyZs_OUT 
rm $OMyZs_OUT
echo $0
chsh -s $(which zsh)
zsh
