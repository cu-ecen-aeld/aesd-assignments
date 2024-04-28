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
./test-unit.sh

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
else
    echo "No assignment specified in conf/assignment.txt, so no additional assignment script"
    echo "testing performed.  To define the assignment, place a conf/assignment.txt file with"
    echo "single line matching a directory name under assignment-autotest/test"
fi
