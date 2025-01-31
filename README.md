# Steps
1. Setup `exo config` CLI
2. `make os_template`
3. `make build`
4. `ssh debian@IP`
5. `sudo su`
6. `nvidia smi`
7. `grep nvidia /var/lib/rancher/k3s/agent/etc/containerd/config.toml`
8. `docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi`


This is an extension of the exocli Command Line Interface (CLI) tool. This extension is designed to help users effectively leverage GPU resources for AI model training. It simplifies the use of the existing GPU resources for short running jobs.

This project uses `mkosi` to create a bootable disk image for a Debian-based system with CUDA and NVIDIA drivers.

## Project Structure
* `HOWTO.md`: Instructions for setting up and using the project.
* `iommu.sh`: Script to list IOMMU groups and devices.
* `mkosi.conf.d/mkosi.conf`: Configuration file for mkosi.
* `mkosi.extra/`: Additional files to be included in the image.
* `mkosi.pkgmngr/`: Package manager configuration files.
* `mkosi.prepare.chroot`: Script to run in the chroot environment.
* `mkosi.skeleton/`: Skeleton directory structure for the image.
* `README.md`: This file.

## Project Description and Purpose
The purpose of this project is to provide a streamlined way to create a bootable disk image for a Debian-based system with CUDA and NVIDIA drivers. This allows users to effectively leverage GPU resources for AI model training and other GPU-intensive tasks.

## Prerequisites and Installation Steps
1. Install mkosi:
    ```sh
    sudo apt install mkosi
2. Install Dependencies
    ```sh
    mkosi dependencies | xargs -d '\n' sudo apt install -y
3. Generate SSH Key
    ```sh 
    mkosi genkey
4. Build and Boot the Image:
    ```sh
    mkosi boot

## Usage Instructions
1. Verify IOMMU Groups: Run the `iommu.sh` script to list IOMMU groups and devices:
    ```sh
    ./iommu.sh
2. Prepare Chroot Environment: The `mkosi.prepare.chroot` script will install necessary Python packages:
    ```sh
    ./mkosi.prepare.chroot
3. Check NVIDIA and CUDA Repositories: Ensure the CUDA and NVIDIA repository lists are correctly placed in the image:
* `mkosi.skeleton/etc/apt/sources.list.d/cuda-debian12-x86_64.list`
* `mkosi.skeleton/etc/apt/sources.list.d/nvidia.list`
* `mkosi.pkgmngr/etc/apt/sources.list.d/cuda-debian12-x86_64.list`
* `mkosi.pkgmngr/etc/apt/sources.list.d/nvidia.list`
4. Run the Image: Boot the generated image and verify all configurations are correct.

## Contributing Guidelines
We welcome contributions from the community. Please follow these guidelines when contributing to the project:
1. Fork the repository and create a new branch for your feature or bugfix.
2. Write clear and concise commit messages.
3. Ensure your code follows the project's coding standards.
4. Submit a pull request with a detailed description of your changes.

## License Information
This project is licensed under the MIT License. See the LICENSE file for more information.
