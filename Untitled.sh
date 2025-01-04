#!/bin/sh

serial_number=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $4}')
serial_number=$(echo $serial_number | tr -d '\n')
sw_vers_output=$(sw_vers)
formatted_output=$(echo "$sw_vers_output" | tr -s '	')
product_type=$(sysctl hw.model | awk -F ' ' '{print $2}')
product_type=$(echo $product_type | tr -d '\n')

echo "\n"
echo "Serial Number:	$serial_number"
echo "Product Type:	$product_type"
echo "$formatted_output"
echo "\n"

tmpVolume="/Volumes/MacMdm"

echo "Mount Volume..."
if [ ! -e "$tmpVolume" ]; then
    diskutil erasevolume HFS+ 'MacMdm' `hdiutil attach -nomount ram://30720` >/dev/null 2>&1
fi
