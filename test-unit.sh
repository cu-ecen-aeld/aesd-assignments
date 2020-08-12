#!/bin/bash
# Run unit tests for the assignment

# Automate these steps from the readme:
# Create a build subdirectory, change into it, run
# cmake .. && make && run the assignment-autotest application
mkdir -p build
cd build
cmake ..
make clean
make
cd ..
./build/assignment-autotest/assignment-autotest
if [ $? -eq 0 ]; then
    which valgrind
    if [ $? -ne 0 ]; then
        echo "Please install valgrind with sudo apt-get install valgrind"
        exit 1
    fi
    echo "Autotest passed, re-running with valgrind to ensure no memory leaks"
    valgrind --leak-check=full --error-exitcode=1 ./build/assignment-autotest/assignment-autotest
    rc=$?
    if [ $rc -ne 0 ]; then
        echo "Valgrind test failed, memory leaks found"
        exit $rc
    else
        echo "Valgrind test succeeded"
    fi
fi
