#!/bin/bash

# Dynamically get the root directory where deploy.sh is
# located (this will work regardless of where .dotfiles
# is placed or renamed)
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Set the root directory to the script's directory
# (i.e., where deploy.sh is)
DOTFILES_DIR="$SCRIPT_DIR"

# Source utility scripts
source "$SCRIPT_DIR/scripts/utils/print.sh"
source "$SCRIPT_DIR/scripts/utils/symlinks.sh"

# Source deployment scripts
source "$SCRIPT_DIR/scripts/deploy/symlinks.sh"

# Execute the deployment
deploy_symlinks
