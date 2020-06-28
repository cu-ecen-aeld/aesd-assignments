cmake_minimum_required(VERSION 3.0.0)
project(aesd-assignments)
# A list of all automated test source files
# At minimum it should include the files in the test/assignmentX directory
# reference this working directory
set(AUTOTEST_SOURCES
    test/assignment1/Test_hello.c
    test/assignment1/Test_assignment_validate.c
)
# A list of all files containing test code that is used for assignment validation
set(TESTED_SOURCE
    ../examples/autotest-validate/autotest-validate.c
)
add_subdirectory(assignment-autotest)
