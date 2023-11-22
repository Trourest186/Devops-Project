#!/bin/bash

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <number_of_workers>"
  exit 1
fi

n=$1
input_file="create-time-private-ip.yml"
output_file="create-time-private-ip.yml"

# Backup existing file content
cp "$input_file" "${input_file}.bak"

# Read input numbers from file
mapfile -t numbers < "${input_file}.bak"

# Add master line
echo "master: ${numbers[0]}" > "$output_file"

# Add lines for workers
for ((i=1; i<=n; i++)); do
  label="worker$i"
  value=${numbers[i]}
  echo "$label: $value" >> "$output_file"
done


rm -f create-time-private-ip.yml.bak
