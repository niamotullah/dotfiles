#!/bin/bash

# Get the directory of this script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Source utilities
source "$SCRIPT_DIR/scripts/utils/print.sh"

# Function to resolve XDG_CONFIG_HOME if not set
resolve_config_home() {
	if [ -z "$XDG_CONFIG_HOME" ]; then
		# Default to ~/.config if XDG_CONFIG_HOME is not set
		echo "$HOME/.config"
	else
		echo "$XDG_CONFIG_HOME"
	fi
}

# Function to create a symlink
create_symlink() {
	local source=$1
	local destination=$2

	# Check if source exists
	if [ ! -e "$source" ]; then
		printErr "Source file or directory '$source' does not exist."
		return 1
	fi

	# Check if the destination already exists
	if [ -e "$destination" ] || [ -L "$destination" ]; then
		printWarn "Destination '$destination' already exists. Skipping symlink creation."
		return 1
	fi

	# Create the symlink
	ln -s "$source" "$destination"
	if [ $? -eq 0 ]; then
		printSuccess "Symlink created: $destination -> $source"
		return 0
	else
		printErr "Failed to create symlink: $destination -> $source"
		return 1
	fi
}

# Process symlinks.conf dynamically
# Process symlinks.conf dynamically
process_symlinks() {
	local config_file=$1
	local config_dir=$(dirname "$(realpath "$config_file")") # Get directory of the config file

	# Check if the config file exists
	if [ ! -f "$config_file" ]; then
		printErr "Configuration file '$config_file' not found."
		return 1
	fi

	# Iterate through each line in the config file
	while IFS=":" read -r source destination; do
		# Skip empty lines and comments
		[[ -z "$source" || "$source" =~ ^# ]] && continue

		# Resolve paths relative to the root of the .dotfiles directory
		# Ensure the relative paths are resolved correctly based on the script location
		abs_source=$(realpath -m "$config_dir/../../$source") # Resolve relative paths to the root of .dotfiles
		abs_destination=$(eval echo "$destination")           # Resolve environment variables in destination

		# Check if the source exists
		if [ ! -e "$abs_source" ]; then
			printErr "Source file or directory '$abs_source' does not exist."
			continue
		fi

		# Create the symlink
		create_symlink "$abs_source" "$abs_destination"
	done <"$config_file" # Read the config file line by line
}
