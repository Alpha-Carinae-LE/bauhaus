#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt install -y build-essential libssl-dev libffi-dev apt-transport-https curl python3 python3-pip
sudo apt install -y software-properties-common ppa-purge

exit 0;