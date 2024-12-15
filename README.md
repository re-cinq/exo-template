# Steps
1. Setup `exo config` CLI
2. `make os_template`
3. `make build`
4. `ssh debian@IP`
5. `sudo su`
6. `nvidia smi`
7. `grep nvidia /var/lib/rancher/k3s/agent/etc/containerd/config.toml`
8. `docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi`
