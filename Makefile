ZONE:=at-vie-1
ORG:=re-cinq

SHELL=/bin/env bash

build:
	mkosi --tools-tree=default --force build

boot:
	mkosi --tools-tree=default --force boot

convert:
	qemu-img convert -f raw -O qcow2 image.raw image.qcow2

clean:
	mkosi clean && rm image.qcow2

hash:
	md5sum image.qcow2

create_bucket:
	exo storage mb sos://${ORG}-${ZONE} --acl public-read -z ${ZONE}

upload:
	exo storage upload image.qcow2 sos://${ORG}-${ZONE}

upload_permissions:
	exo storage setacl -r sos://${ORG}-${ZONE}/image.qcow2 public-read

register:
	exo compute instance-template register ai-jobs $(shell exo storage show ${ORG}-${ZONE}/image.qcow2 --output-format json | jq '.url') $(shell md5sum image.qcow2 | awk '{print $$1}') --boot-mode uefi --disable-password --username debian --zone ${ZONE} --description \"nvidia debian template ${ZONE}\"

os_template: clean build convert upload upload_permissions register

init:
	mkosi genkey

# These rules do not correspond to a specific file
.PHONY: build boot convert clean hash create_bucket upload upload_permissions register os_template init
