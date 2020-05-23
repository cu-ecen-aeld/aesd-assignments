#include "unity.h"
#include <stdbool.h>
#include <stdlib.h>
#include "../../examples/autotest-validate/autotest-validate.h"
#include "../../assignment-autotest/test/assignment1/username-from-conf-file.h"

/**
* Verify we can automated test code in the "examples" directory within your project
* This function should:
*   1) Call the my_username() function in Test_assignment_validate.c
*   2) Use the value returned from function malloc_username_from_conf_file() in username-from-conf-file.h within
*       the assignment autotest submodule at assignment-autotest/test/assignment1/
*   3) Use unity assertion TEST_ASSERT_EQUAL_STRING_MESSAGE the two strings are equal.  See
*       the unity assertion reference at https://github.com/ThrowTheSwitch/Unity/blob/master/docs/UnityAssertionsReference.md
*/
void test_validate_my_username()
{
/**
 * TODO: Replace the line below with your code here as described above to verify your /conf/username.txt config file and my_username() functions are setup properly
 */
    TEST_ASSERT_TRUE_MESSAGE(false,"AESD students, please fix me!");
}
