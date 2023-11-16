SHELL := /bin/bash

CURR_DIR = $(CURDIR)
USER_DIR = $(HOME)

##########################################
#
# UTILITY OPERATIONS
#
##########################################
.PHONY: pull-alma
pull-alma:
	@docker pull almalinux:latest

.PHONY: pull-alpine
pull-alpine:
	@docker pull alpine:latest

.PHONY: pull-arch
pull-arch:
	@docker pull archlinux:latest

.PHONY: pull-debian
pull-debian:
	@docker pull debian:latest

.PHONY: pull-ubuntu
pull-ubuntu:
	@docker pull ubuntu:jammy

##########################################
#
# START / STOP CONTAINERS
#
##########################################
.PHONY: start-alma
start-alma:
	@docker run -d --hostname alma almalinux:latest

.PHONY: start-alpine
start-alpine:
	@docker run -d --hostname alpine alpine:latest

.PHONY: start-arch
start-arch:
	@docker run -d --hostname arch archlinux:latest

.PHONY: start-debian
start-debian:
	@docker run -d --hostname debian debian:latest

.PHONY: start-ubuntu
start-ubuntu:
	@docker run -d --hostname ubuntu ubuntu:jammy

.PHONY: stop-alma
stop-alma:
	@docker stop alma

.PHONY: stop-alpine
stop-alpine:
	@docker stop alpine

.PHONY: stop-arch
stop-arch:
	@docker stop arch

.PHONY: stop-debian
stop-debian:
	@docker stop debian

.PHONY: stop-ubuntu
stop-ubuntu:
	@docker stop ubuntu
