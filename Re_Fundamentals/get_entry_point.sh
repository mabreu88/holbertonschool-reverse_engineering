#!/bin/bash

# Verify arguments
if [ $# -ne 1 ]; then
    echo "Use: $0 <ELF file>"
    exit 1
fi

file_name="$1"

# File exist?
if [ ! -f "$file_name" ]; then
    echo "Error: The file '$file_name' no exist."
    exit 1
fi

# its a valid ELF? (Drows dont count)
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' not a valid ELF file."
    exit 1
fi

# Extract elf header
magic_number=$(hexdump -n 16 -e '12/1 "%02x " "\n"' "$file_name")
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2, $3}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk '{print $2, $3}')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

# Import  messages.sh
source ./messages.sh

# Call function to show info
display_elf_header_info

