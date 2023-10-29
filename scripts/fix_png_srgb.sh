#!/bin/bash

# Check if the parent folder path is provided as a parameter
if [ -z "$1" ]; then
  echo "Please provide the path to the parent folder as a parameter."
  exit 1
fi

# Iterate through all the subfolders and check for incorrect sRGB profiles in PNG images
find "$1" -type f -name "*.png" | while read file; do
  if pngcrush -n -q "$file" 2>&1 | grep -q "known incorrect sRGB profile"; then
    echo "$file has incorrect sRGB profile, fixing..."
    pngcrush -s -ow -rem allb -reduce "$file"
    echo "$file: fixed sRGB profile"
  fi
done