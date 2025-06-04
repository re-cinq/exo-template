ZONE:=at-vie-1
ORG:=re-cinq
SHA1   := $(shell git rev-parse --short HEAD)

SHELL=/bin/env bash
MKOSI=./mkosi/bin/mkosi

build:
	@echo "Building requires root. Type your password or CTRL-C to stop."
	sudo $(MKOSI) --tools-tree=default --force build

boot:
	$(MKOSI) --tools-tree=default --force boot

convert:
	qemu-img convert -f raw -O qcow2 image.raw exoscale-lab-ai-$(SHA1).qcow2
	ln -s exoscale-lab-ai-$(SHA1).qcow2 image.qcow2

clean:
	sudo rm -f *.deb
	sudo $(MKOSI) clean
	rm -f *.qcow2

hash:
	md5sum image.qcow2

create_bucket:
	exo storage mb sos://${ORG}-${ZONE} --acl public-read -z ${ZONE}

upload:
	exo storage upload image.qcow2 sos://${ORG}-${ZONE}

upload_permissions:
	exo storage setacl -r sos://${ORG}-${ZONE}/image.qcow2 public-read

register:
	exo compute instance-template register --description 'Linux Debian 12 (Bookworm) 64-bit GPU' linux-debian-12-gpu $(shell exo storage show ${ORG}-${ZONE}/image.qcow2 --output-format json | jq '.url') $(shell md5sum image.qcow2 | awk '{print $$1}') --boot-mode uefi --disable-password --username debian --zone ${ZONE} --description \"nvidia debian template ${ZONE}\"

os_template: build convert upload upload_permissions register

mkosi-install:
	[ ! -d mkosi ] && \
	  git clone --depth 1 --branch 'v25.3' https://github.com/systemd/mkosi

prereq: mkosi-install
	sudo apt install debian-archive-keyring qemu-utils

init: prereq
	$(MKOSI) genkey

# These rules do not correspond to a specific file
.PHONY: build boot convert clean hash create_bucket upload upload_permissions register os_template init mkosi-install prereq
