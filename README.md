### Exoscale GPU-Enabled Template Builder
This repository contains tools and configurations to create a custom Debian-based VM template for Exoscale with NVIDIA GPU support, CUDA, and Kubernetes (k3s) pre-installed.

#### Overview
The project uses mkosi to build a custom Debian Bookworm image with:

- NVIDIA drivers and CUDA 12.6.3
- Docker with NVIDIA container runtime
- k3s (lightweight Kubernetes)
- AI Operator for managing ML workloads
- Pre-configured NVIDIA device plugin for Kubernetes

#### Prerequisites
- Exoscale CLI (`exo`) installed and configured
- `mkosi` installed on your system
- `qemu-utils` for image conversion
- Access to Exoscale account and API credentials

#### Usage

Building the Template

1. Initialize the build environment:
```BASH
make init
```

2. Build the image:
```BASH
make build
```

3. Convert the raw image to qcow2
```BASH
make convert
```

4. Create a storage bucket and upload the image:
```BASH
make create_bucket
make upload_permissions
make upload
```

5. Register the template
```BASH
make register
```

There is also the possibility to do all steps at once:
```BASH
make os_template
```

#### Using the Template

1. Create a VM using the template:
```BASH
exo compute instance create \
  --instance-type gpu2.small \
  --template <template-id> \
  --zone at-vie-1 \
  --disk-size 100 \
  --ssh-key <your-ssh-key> \
  ai
```

2. The VM comes pre-configured with:

- k3s Kubernetes cluster
- NVIDIA device plugin
- AI operator for managing ML workloads
- Docker with NVIDIA runtime
- k9s

### Key Components

- `mkosi.conf`: Main configuration for building the Debian image
- `mkosi.postinst.chroot`: Post-installation script that installs NVIDIA drivers, CUDA, Docker, and k3s
- `manifests`: Example Kubernetes manifests for GPU workloads
- `Dockerfile`: Base container image for GPU workloads
- `Makefile`: Automation for building and deploying the template

#### Directory structure
```
.
├── build.sh           # Build script wrapper
├── convert.sh         # Image conversion script
├── Dockerfile         # GPU-enabled container base image
├── manifests/         # Kubernetes manifests
├── mkosi.conf        # Main mkosi configuration
├── mkosi.extra/      # Additional files for the image
└── mkosi.postinst.chroot  # Post-installation configuration
```

### Development

To modify the image:

1. Edit mkosi.conf for base system configuration
2. Modify mkosi.postinst.chroot for software installation
3. Update mkosi.extra for additional files
4. Re-build the image via: `make os_template`

### Troubleshooting

1. Verify NVIDIA drivers:

```BASH
nvidia-smi
```

2. Check container runtime:
```BASH
docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

3. Verify k3s status:
```BASH
systemctl status k3s
```

## Contributing Guidelines
We welcome contributions from the community. Please follow these guidelines when contributing to the project:
1. Fork the repository and create a new branch for your feature or bugfix.
2. Write clear and concise commit messages.
3. Ensure your code follows the project's coding standards.
4. Submit a pull request with a detailed description of your changes.

## License Information
This project is licensed under the MIT License. See the LICENSE file for more information.
