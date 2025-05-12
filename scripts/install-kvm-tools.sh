#!/bin/bash

#: Title       : install-kvm-tools.sh
#: Date        : May 11 2025
#: Author      : Luis
#: Version     : 1.0
#: Description : Installs KVM, libvirt, and virtualization tools
#: Options     : None

set -e

# Color variables
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${GREEN}Installing virtualization tools...${RESET}"
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients virt-manager bridge-utils

echo -e "${GREEN}Adding current user to libvirt and kvm groups...${RESET}"
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)

echo -e "${GREEN}KVM and virtualization tools installed.${RESET}"
echo -e "${YELLOW}Please reboot or log out/log in to apply group membership changes.${RESET}"
