#!/usr/bin/env bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm python python-pip
sudo pacman -S --noconfirm reflector

exit 0;