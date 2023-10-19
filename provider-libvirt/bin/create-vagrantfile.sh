#!/usr/bin/bash

##########################################
#
# GLOBAL VARIABLES
#
##########################################
ALMA_FLAG="--alma"
ALPINE_FLAG="--alpine"
ARCH_FLAG="--arch"
DEBIAN_FLAG="--debian"
UBUNTU_FLAG="--ubuntu"

##########################################
#
# FUNCTIONS TO CREATE VAGRANTFILES
#
##########################################
function vf-create-Alma() {
  [[ ! -e Vagrantfile ]] && touch Vagrantfile
  cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
  {
    :name => "majima",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.11"
  },
  {
    :name => "kiryu",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.12"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/alma9"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider "libvirt" do |lbv|
        lbv.driver = "kvm"
        lbv.memory = vars[:memory]
        lbv.cpus = vars[:cpus]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-dnf.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Alpine() {
  [[ ! -e Vagrantfile ]] && touch Vagrantfile
  cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
  {
    :name => "shepard",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.21"
  },
  {
    :name => "vakarian",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.22"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/alpine318"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider "libvirt" do |lbv|
        lbv.driver = "kvm"
        lbv.memory = vars[:memory]
        lbv.cpus = vars[:cpus]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apk.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Arch() {
  [[ ! -e Vagrantfile ]] && touch Vagrantfile
  cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
  {
    :name => "calvin",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.31"
  },
  {
    :name => "hobbes",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.32"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/arch"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider "libvirt" do |lbv|
        lbv.driver = "kvm"
        lbv.memory = vars[:memory]
        lbv.cpus = vars[:cpus]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "file", source: "./certificates/mirrorlist", destination: "/tmp/mirrorlist"
      machine.vm.provision "shell", inline: "/bin/cp -rf /tmp/mirrorlist /etc/pacman.d/mirrorlist"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-pac.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Debian() {
  [[ ! -e Vagrantfile ]] && touch Vagrantfile
  cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
  {
    :name => "snoopy",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.41"
  },
  {
    :name => "woodstock",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.42"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/debian11"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider "libvirt" do |lbv|
        lbv.driver = "kvm"
        lbv.memory = vars[:memory]
        lbv.cpus = vars[:cpus]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apt.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Ubuntu() {
  [[ ! -e Vagrantfile ]] && touch Vagrantfile
  cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
  {
    :name => "mario",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.51"
  },
  {
    :name => "luigi",
    :cpus => "2",
    :memory => "4096",
    :address => "192.168.56.52"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider "libvirt" do |lbv|
        lbv.driver = "kvm"
        lbv.memory = vars[:memory]
        lbv.cpus = vars[:cpus]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apt.sh"
    end
  end
end
EOF
  exit 0;
}
##########################################
#
# CALLING FUNCTION BY FLAG
#
##########################################
case $1 in
  "$ALMA_FLAG")
    vf-create-Alma
  ;;
  "$ALPINE_FLAG")
    vf-create-Alpine
  ;;
  "$ARCH_FLAG")
    vf-create-Arch
  ;;
  "$DEBIAN_FLAG")
    vf-create-Debian
  ;;
  "$UBUNTU_FLAG")
    vf-create-Ubuntu
  ;;
  *)
    echo "You think you're so damn clever don't you?"
    exit 1;
  ;;
esac