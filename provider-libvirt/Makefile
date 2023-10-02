SHELL := /bin/bash

CURR_DIR = $(CURDIR)
USER_DIR = $(HOME)

##########################################
#
# UTILITY OPERATIONS
#
##########################################
.PHONY: vf-alma
vf-alma:
	@./bin/create-vagrantfile.sh --alma

.PHONY: vf-alpine
vf-alpine:
	@./bin/create-vagrantfile.sh --alpine

.PHONY: vf-arch
vf-arch:
	@./bin/create-vagrantfile.sh --arch

.PHONY: vf-debian
vf-debian:
	@./bin/create-vagrantfile.sh --debian

.PHONY: vf-ubuntu
vf-ubuntu:
	@./bin/create-vagrantfile.sh --ubuntu

##########################################
#
# GLOBAL VAGRANT OPERATIONS
#
##########################################
.PHONY: vm-box-add
vm-box-add:
	@vagrant box add generic/alma9  --provider=libvirt --force --clean
	@vagrant box add generic/alpine38 --provider=libvirt --force --clean
	@vagrant box add generic/arch --provider=libvirt --force --clean
	@vagrant box add generic/debian11 --provider=libvirt --force --clean
	@vagrant box add bento/ubuntu-22.04 --provider=libvirt --force  --clean

.PHONY: vm-box-check
vm-box-check:
	@vagrant box outdated --force

.PHONY: vm-box-list
vm-box-list:
	@vagrant box list

.PHONY: vm-box-nuke
vm-box-nuke:
	@vagrant box remove generic/alma9  --provider=libvirt --force --all
	@vagrant box remove generic/alpine38 --provider=libvirt --force --all
	@vagrant box remove generic/arch --provider=libvirt --force --all
	@vagrant box remove generic/debian11 --provider=libvirt --force --all
	@vagrant box remove bento/ubuntu-22.04 --provider=libvirt --force  --all

.PHONY: vm-box-health
vm-box-status:
	@vagrant global-status --prune

.PHONY: vm-box-update
vm-box-update:
	@vagrant box update
	@vagrant box prune --keep-active-boxes --force

##########################################
#
# CURRENT VAGRANT ENV OPERATIONS
#
##########################################
.PHONY: vm-destroy
vm-destroy:
	@vagrant destroy --force --graceful

.PHONY: vm-down
vm-down:
	@vagrant halt

.PHONY: vm-provision
vm-provision:
	@vagrant reload --provision

.PHONY: vm-resume
vm-resume:
	@vagrant resume

.PHONY: vm-status
vm-status:
	@vagrant status

.PHONY: vm-suspend
vm-suspend:
	@vagrant suspend

.PHONY: vm-up
vm-up:
	@vagrant up

.PHONY: vm-snapshot-save
vm-snapshot-save:
	@vagrant snapshot save latest

.PHONY: vm-snapshot-restore
vm-snapshot-restore:
	@vagrant snapshot restore latest

.PHONY: vm-snapshot-remove
vm-snapshot-remove:
	@vagrant snapshot delete latest

.PHONY: vm-snapshot-save-wip
vm-snapshot-save-wip:
	@vagrant snapshot save wip

.PHONY: vm-snapshot-restore-wip
vm-snapshot-restore-wip:
	@vagrant snapshot restore wip

.PHONY: vm-snapshot-remove-wip
vm-snapshot-remove-wip:
	@vagrant snapshot delete wip

.PHONY: vm-snapshot-list
vm-snapshot-list:
	@vagrant snapshot list

.PHONY: vm-forget
vm-forget: alma-forget alpine-forget arch-forget debian-forget ubuntu-forget

.PHONY: alma-forget
alma-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.11"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.12"

.PHONY: alpine-forget
alpine-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.21"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.22"

.PHONY: arch-forget
arch-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.31"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.32"

.PHONY: debian-forget
debian-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.41"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.42"

.PHONY: ubuntu-forget
ubuntu-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.51"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.52"

##########################################
#
# INITIALIZE AND TERMINATE ENVIRONMENTS
#
##########################################
.PHONY: alma-init
alma-init: vf-alma vm-up

.PHONY: alpine-init
alpine-init: vf-alpine vm-up

.PHONY: arch-init
arch-init: vf-arch vm-up

.PHONY: deb-init
deb-init: vf-debian vm-up

.PHONY: ubuntu-init
ubuntu-init: vf-ubuntu vm-up

.PHONY: alma-term
alma-term: vf-alma alma-forget vm-destroy

.PHONY: alpine-term
alpine-term: vf-alpine alpine-forget vm-destroy

.PHONY: arch-term
arch-term: vf-arch arch-forget vm-destroy

.PHONY: deb-term
deb-term: vf-debian debian-forget vm-destroy

.PHONY: ubuntu-term
ubuntu-term: vf-ubuntu ubuntu-forget vm-destroy

##########################################
#
# ANSIBLE COMMANDS
#
##########################################
.PHONY: ans-show-nodes
ans-show-nodes:
	@ANSIBLE_DISPLAY_SKIPPED_HOSTS=false \
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook \
	-i ${CURR_DIR}/ansible/inventory/hosts.yml \
	${CURR_DIR}/ansible/playbook.yml