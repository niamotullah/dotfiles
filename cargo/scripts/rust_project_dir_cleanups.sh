#!/bin/bash

# Default starting directory is current directory
start_dir="$(pwd)"

# Parse command-line arguments
if [ $# -gt 0 ]; then
	# Handle trailing slashes by removing them
	clean_dir="${1%/}"

	# Convert to absolute path
	if [ -d "$clean_dir" ]; then
		start_dir="$(cd "$clean_dir" && pwd)"
	else
		echo "Error: Directory '$clean_dir' does not exist" >&2
		exit 1
	fi
fi

echo "Searching for Rust projects in: $start_dir"

# Find all Cargo.toml files (excluding hidden directories)
find "$start_dir" -type d -name '.*' -prune -o -type f -name 'Cargo.toml' -print | while read -r cargo_file; do
	project_dir=$(dirname "$cargo_file")

	echo "Cleaning Rust project: $project_dir"
	(cd "$project_dir" && cargo clean)
done

echo "Rust project cleaning complete"
