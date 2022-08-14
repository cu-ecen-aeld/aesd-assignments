#!/bin/sh
module=aesdchar
device=aesdchar
mode="664"
cd `dirname $0`
set -e
# Group: since distributions do it differently, look for wheel or use staff
if grep -q '^staff:' /etc/group; then
    group="staff"
else
    group="wheel"
fi

if [ -e ${module}.ko ]; then
    echo "Loading local built file ${module}.ko"
    insmod ./$module.ko $* || exit 1
else
    echo "Local file ${module}.ko not found, attempting to modprobe"
    modprobe ${module} || exit 1
fi
major=$(awk "\$2==\"$module\" {print \$1}" /proc/devices)
rm -f /dev/${device}
mknod /dev/${device} c $major 0
chgrp $group /dev/${device}
chmod $mode  /dev/${device}
