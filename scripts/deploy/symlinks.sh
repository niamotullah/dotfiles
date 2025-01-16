#!/bin/bash

# Function to recursively search for 'dotconfig/symlinks.conf'
find_symlinks_configs() {
	local root_dir=$1
	find "$root_dir" -type f -name "symlinks.conf" -path "*/dotconfig/symlinks.conf"
}

# Main deployment logic
deploy_symlinks() {
	# Use DOTFILES_DIR as the root directory
	real_dotfiles_dir=$(realpath "$DOTFILES_DIR") # Resolve to absolute path
	# printInfo "Searching for 'dotconfig/symlinks.conf' files in $real_dotfiles_dir/"

	# Find all 'symlinks.conf' files
	config_files=$(find_symlinks_configs "$real_dotfiles_dir")

	if [ -z "$config_files" ]; then
		printWarn "No 'dotconfig/symlinks.conf' files found in $real_dotfiles_dir."
		return 0
	fi

	# Process each symlinks.conf file
	while IFS= read -r config_file; do
		real_config_file=$(realpath "$config_file") # Resolve to absolute path
		# printInfo "Processing symlinks from: $real_config_file"
		process_symlinks "$config_file"
	done <<<"$config_files"

	# printSuccess "Deployment completed."
}
