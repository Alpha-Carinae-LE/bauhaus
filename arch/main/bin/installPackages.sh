#!/usr/bin/env bash

# DO NOT TOUCH UNLESS YOU
# KNOW WHAT YOU'RE DOING!
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm go python python-pip ansible
exit 0;