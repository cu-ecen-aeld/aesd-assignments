#!/bin/bash
# Script outline to install and build kernel.
# Author: Siddhant Jajoo.

set -e
set -u

OUTDIR=/tmp/aeld
KERNEL_REPO=git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
#KERNEL_VERSION=v5.1.10
KERNEL_VERSION=v5.19.17
BUSYBOX_VERSION=1_33_1
FINDER_APP_DIR=$(realpath $(dirname $0))
ARCH=arm64
CROSS_COMPILE=aarch64-none-linux-gnu-
#CROSS_COMPILE=aarch64-linux-gnu-

if [ $# -lt 1 ]
then
	echo "Using default directory ${OUTDIR} for output"
else
	OUTDIR=$1
	echo "Using passed directory ${OUTDIR} for output"
fi

mkdir -p ${OUTDIR}

cd "$OUTDIR"
if [ ! -d "${OUTDIR}/linux-stable" ]; then
    #Clone only if the repository does not exist.
	echo "CLONING GIT LINUX STABLE VERSION ${KERNEL_VERSION} IN ${OUTDIR}"
	git clone ${KERNEL_REPO} --depth 1 --single-branch --branch ${KERNEL_VERSION}
fi
if [ ! -e ${OUTDIR}/linux-stable/arch/${ARCH}/boot/Image ]; then
    cd linux-stable
    echo "Checking out version ${KERNEL_VERSION}"
    git checkout ${KERNEL_VERSION}

    # TODO: Add your kernel build steps here
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE mrproper
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE defconfig
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE all -j 4
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE modules
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE dtbs
fi

echo "Adding the Image in outdir"
cp -u ${OUTDIR}/linux-stable/arch/${ARCH}/boot/Image ${OUTDIR}
echo "Creating the staging directory for the root filesystem"
cd "$OUTDIR"
if [ -d "${OUTDIR}/rootfs" ]
then
	echo "Deleting rootfs directory at ${OUTDIR}/rootfs and starting over"
        sudo rm  -rf ${OUTDIR}/rootfs
fi

# TODO: Create necessary base directories
mkdir rootfs
cd rootfs
mkdir -p bin dev etc home lib lib64 proc sbin sys tmp usr var
mkdir -p usr/bin usr/lib usr/sbin
mkdir -p var/log

cd "$OUTDIR"
if [ ! -d "${OUTDIR}/busybox" ]
then
git clone git://busybox.net/busybox.git
    cd busybox
    git checkout ${BUSYBOX_VERSION}
    # TODO:  Configure busybox
    make distclean
    make defconfig
else
    cd busybox
fi

# TODO: Make and install busybox
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE}
make CONFIG_PREFIX=${OUTDIR}/rootfs ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} install

echo "Library dependencies"
cd ${OUTDIR}/rootfs
${CROSS_COMPILE}readelf -a bin/busybox | grep "program interpreter"
${CROSS_COMPILE}readelf -a bin/busybox | grep "Shared library"
# TODO: Add library dependencies to rootfs
VAR=$(${CROSS_COMPILE}readelf -a bin/busybox | grep "program interpreter" | awk '{print $4}')
VAR=${VAR::-1}
VAR=$(echo $VAR | awk -F '/lib/' '{print $2}')
LOOKIN=$(which aarch64-none-linux-gnu-gcc)
LOOKIN=$(echo $LOOKIN | awk -F '/bin/' '{print $1}')
find ${LOOKIN}/aarch64-none-linux-gnu/ -name ${VAR} -exec cp {} ${OUTDIR}/rootfs/lib \;
if [ -e ${OUTDIR}/rootfs/lib/${VAR} ]
then
   echo "copy program interpeter ${VAR} into lib directory" 
fi
VAR=$(aarch64-none-linux-gnu-readelf -a bin/busybox | grep "Shared" | awk '{print $5}' | sed 's/[][]//g')
for token in ${VAR};
do
   echo "${token}" | xargs -I {} cp ${LOOKIN}/${CROSS_COMPILE::-1}/libc/lib64/{} ${OUTDIR}/rootfs/lib64/; 
   if [ -e ${OUTDIR}/rootfs/lib64/${token} ]
   then
       echo copy ${token} into lib64 directory
   fi
done
# TODO: Make device nodes
sudo mknod -m 644 ./dev/console c 5 1
sudo mknod -m 666 ./dev/null c 1 3

# TODO: Clean and build the writer utility
cd ${FINDER_APP_DIR}
make clean
make CROSS_COMPILE=${CROSS_COMPILE}

# TODO: Copy the finder related scripts and executables to the /home directory
# on the target rootfs
cp -RL ${FINDER_APP_DIR}/* ${OUTDIR}/rootfs/home

# TODO: Chown the root directory
sudo chown -hR root:root ${OUTDIR}/rootfs
# TODO: Create initramfs.cpio.gz
cd ${OUTDIR}/rootfs
find . | cpio -H newc -ov --owner root:root > ${OUTDIR}/initramfs.cpio
cd ${OUTDIR}
gzip -f -v initramfs.cpio
echo ${PWD}
ls -l
