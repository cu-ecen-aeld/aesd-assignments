#!/bin/sh
# This script can be copied into your base directory for use with
# automated testing using assignment-autotest.  It automates the
# steps described in https://github.com/cu-ecen-5013/assignment-autotest/blob/master/README.md#running-tests
set -e
cd `dirname $0`
# Create a build subdirectory, change into it, run
# cmake .. && make && run the assignment-autotest application
mkdir -p build
cd build
cmake ..
make
./assignment-autotest/assignment-autotest
echo "Test complete with success"
