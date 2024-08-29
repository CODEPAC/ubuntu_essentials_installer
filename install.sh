#! /bin/bash
apt update
packages=(vim git curl)
echo -n "the following packages will be installed"

echo $packages

for package in "${packages[@]}"; do 
    echo "installing $package"
    apt install  -oDebug::pkgAcquire::Worker=1  -y -f "$package"
done
