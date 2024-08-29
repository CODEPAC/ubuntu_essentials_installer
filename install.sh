#!/bin/sh
ESSENTIALS= "curl git vim"
apt update
apt install  -oDebug::pkgAcquire::Worker=1  $ESSENTIALS
