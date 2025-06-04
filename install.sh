#!/bin/bash
login_user=$(logname)
echo "Hello $login_user"
USER_HOME="/home/$login_user"
TEMP_FOLDER="$USER_HOME/temp"
mkdir -p $TEMP_FOLDER
echo "$TEMP_FOLDER was created or already exists!"
sudo apt update
packages=(vim wget git curl htop btop libreoffice gnome-tweaks)
dev_packages=(build-essential ffmpeg)
echo -e "the following packages will be installed\n"
echo $packages

for package in "${packages[@]}"; do 
    echo "installing $package ....."
    sudo apt install  -oDebug::pkgAcquire::Worker=1  -y -f "$package"
done
#install dev packages
for package in "${dev_packages[@]}"; do 
    echo "installing $package ....."
    sudo apt install  -oDebug::pkgAcquire::Worker=1  -y -f "$package"
done
# iNSTALL  dropbox
current="$(pwd)"
URL="https://linux.dropbox.com/packages/ubuntu/dropbox_2024.04.17_amd64.deb" 
OUT_LOC="$TEMP_FOLDER/dropbox.deb"
echo "donwlaoding "
echo $URL 
echo "to "
echo $OUT_LOC
curl $URL --output $OUT_LOC
yes | sudo dpkg -i $OUT_LOC
echo "finished installing dropbox, deleting installer"
rm $OUT_LOC
echo "downloading Vscode"
URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
echo $URL
OUT_LOC="$TEMP_FOLDER/vscode_latest_amd64.deb"
wget  --progress=dot:giga $URL -O $OUT_LOC
yes | sudo dpkg -i $OUT_LOC
#install vlc via snap
snap install vlc
# installing OMyZs
echo "installing zsh"
apt install zsh
OMyZs_OUT="./omyzsh_installer.sh"
curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" -o $OMyZs_OUT
echo "installing oh my zsh"
sudo chmod a+x $OMyZs_OUT
sh -c $OMyZs_OUT 
rm $OMyZs_OUT
chsh -s $(which zsh)
echo "installing gnome solarized as $USER"
TEMP_LOC="$TEMP_FOLDER/temprepo"
REPO_URL="https://github.com/aruhier/gnome-terminal-colors-solarized.git"  
DIR_COLORS="/home/$login_user/.dir_colors"
git clone "$REPO_URL"  "$TEMP_LOC"
cd $TEMP_LOC 
echo "entering.."
pwd
ls "."
INSTALL_SCRIPT="./install.sh"
SCHEME="dark"
PROFILE="Soralized Dark"
mkdir -p $DIR_COLORS
#chmod a+x $INSTALL_SCRIPT 
sh -c $INSTALL_SCRIPT -s $SCHEME -p $PROFILE --install-dircolors $DIR_COLORS  

cd "/home/login_user"
sudo rm -r $TEMP_LOC
echo "eval \"\$(dircolors -b $DIR_COLORS/dircolorsdb)\"" >> ~/.zshrc


