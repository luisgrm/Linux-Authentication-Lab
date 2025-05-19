#!/bin/bash

#: Title       : update-system.sh
#: Date        : May 11 2025
#: Author      : Luis
#: Version     : 1.0
#: Description : Updates the Ubuntu Admin VM system packages
#: Options     : None

set -e

echo "Updating package index..."
sudo apt update

echo "Upgrading packages..."
sudo apt upgrade -y

echo "System update and upgrade completed."
