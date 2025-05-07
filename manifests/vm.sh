exo compute instance-template list --visibility private
exo compute instance create --instance-type gpu2.small --template cd4b4434-9bc3-4256-82db-77573946be4d --zone at-vie-1 --disk-size 100 --ssh-key sebastian --template-visibility private ai
exo compute instance create --cloud-init ./userdata.yaml --instance-type gpu2.small --template cd4b4434-9bc3-4256-82db-77573946be4d --zone at-vie-1 --disk-size 100 --ssh-key sebastian --ssh-key sebastian-debian --template-visibility private ai
exo compute instance list
