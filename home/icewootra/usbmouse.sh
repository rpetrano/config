#!/bin/bash

QEMU_URI='qemu:///system'
DEVICE=~/usbmouse.xml
VM=win10

virsh="virsh -c $QEMU_URI"

is_device_attached() {
	device="$1"

	vendorid=$(xmllint "$device" --xpath 'string(/hostdev/source/vendor/@id)')
	productid=$(xmllint "$device" --xpath 'string(/hostdev/source/product/@id)')

	xpath="count(/domain/devices/hostdev[@mode='subsystem' and @type='usb']/source/*[(self::vendor and @id='$vendorid') or (self::product and @id='$productid')])"

	$virsh dumpxml win10 | xmllint --xpath "$xpath" - | xargs test 2 -eq
}

is_device_attached "$DEVICE" &&
	$virsh detach-device "$VM" "$DEVICE" ||
	$virsh attach-device "$VM" "$DEVICE"

