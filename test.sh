#!/bin/bash
# This script can be copied into your base directory for use with
# automated testing using assignment-autotest.  It automates the
# steps described in https://github.com/cu-ecen-5013/assignment-autotest/blob/master/README.md#running-tests
set -e
cd `dirname $0`
if [ -f ./assignment-autotest/docker/options ]; then
    # When run using a docker container on a parent repo, support additional options
    # specifying UID/GID of user
    . ./assignment-autotest/docker/options
    parse_docker_options "$@"
fi
# Automate these steps from the readme:
# Create a build subdirectory, change into it, run
# cmake .. && make && run the assignment-autotest application
mkdir -p build
cd build
cmake ..
make
cd ..
./build/assignment-autotest/assignment-autotest

# If there's a configuration for the assignment number, use this to look for
# additional tests
if [ -f conf/assignment.txt ]; then
    # This is just one example of how you could find an associated assignment
    assignment=`cat conf/assignment.txt`
    if [ -f ./assignment-autotest/test/${assignment}/assignment-test.sh ]; then
    # Optional: If you have other tests to run against the assignment
    # add these to a script under test/${assignment}
        ./assignment-autotest/test/${assignment}/assignment-test.sh
        echo "Test of assignment ${assignment} complete with success"
    else
        echo "No assignment-test script found for ${assignment}, skipping this test"
    fi
fi
