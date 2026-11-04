#include "unity.h"
#include <stdbool.h>
#include <stdlib.h>
#include "../../examples/autotest-validate/autotest-validate.h"
#include "../../assignment-autotest/test/assignment1/username-from-conf-file.h"

/**
 * This function should:
 *   1) Call the my_username() function in autotest-validate.c to get your hard coded username.
 *   2) Obtain the value returned from function malloc_username_from_conf_file() in username-from-conf-file.h
 *   3) Use unity assertion TEST_ASSERT_EQUAL_STRING_MESSAGE to verify the two strings are equal.
 */
void test_validate_my_username()
{
    // 1) Get the hardcoded username from autotest-validate.c
    const char *hardcoded_username = my_username();

    // 2) Obtain the dynamically allocated username from conf/username.txt
    char *conf_username = malloc_username_from_conf_file();

    // 3) Verify the two strings are equal using Unity assertion
    TEST_ASSERT_EQUAL_STRING_MESSAGE(
        hardcoded_username, 
        conf_username, 
        "The username in conf/username.txt does not match the hardcoded my_username() value!"
    );

    // Free the dynamically allocated memory returned by malloc_username_from_conf_file()
    free(conf_username);
}