#!/bin/bash

#: Title       : update-system.sh
#: Date        : May 11 2025
#: Author      : Luis
#: Version     : 1.0
#: Description : Updates the Ubuntu Admin VM system packages
#: Options     : None

set -e # Tells Bash to exit immediately if a command exits with a non-zero status. Ensure script exits on first command failure

echo "Updating package index..."
sudo apt update

echo "Upgrading packages..."
sudo apt upgrade -y

echo "System update and upgrade completed."
