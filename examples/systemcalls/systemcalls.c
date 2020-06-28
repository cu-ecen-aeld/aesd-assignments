#include "systemcalls.h"

/**
* @param count - The numbers of variables passed to the function.
*   The variables include command to execute with system() and the
*   arguments to use for the command
* @param ...- A list of 1 or more arguments after the @param count function.  
*    Since system() performs path expansion, this does not need to be a full path to the command.
*    These will be appended to a command string before calling system() 
*    with a space separating each parameter.
* @return true if the commands in ... with arguments @param arguments were executed 
*   successfully using the system() call, false if an error occurred, 
*   either in invocation of the system() command, or if a non-zero return 
*   value was returned by the command issued in @param.
*/
bool do_system(int count, ...)
{
    va_list args;
    va_start(args, count);
    const char * command;
    int i;
    bool null_flag =  false;
    for(i=0; i<count; i++)
    {
        command = va_arg(args, const char *);
        if(command == NULL)
        {
            null_flag = true;
        }

    }

/*
 * TODO  add your code here
 *  Call the system() function with the commands set in the command variable
 *   and return a boolean true if the system() call completed with success 
 *   or false() if it returned a failure
*/

    va_end(args);
    
    return true;
}

/**
* @param count -The numbers of variables passed to the function. The variables are command to execute.  
*   Since exec() does not perform path expansion, the commands need to full paths.
* @param ... - A list of 1 or more arguments after the @param count argument.
*   These will be added to argv[1] and later in the const char * argument 
*   to execv (argv[0] will always be the command).
* @return true if the command @param ... with arguments @param arguments were executed successfully
*   using the execv() call, false if an error occurred, either in invocation of the 
*   fork, waitpid, or execv() command, or if a non-zero return value was returned
*   by the command issued in @param arguments with the specified arguments.
*/

bool do_exec(int count, ...)
{
    va_list args;
    va_start(args, count);
    char * command[count+1];
    int i;
    for(i=0; i<count; i++)
    {
        command[i] = va_arg(args, char *);
    }
    command[count] = NULL;

/*
 * TODO:
 *   Execute a system command by calling fork, execv(),
 *   and wait instead of system (see LSP page 161).
 *   Use the command[0] as the full path to the command to execute
 *   (first argument to execv), and use the remaining arguments
 *   as arguments to the systeem() command.
 *   
*/

    va_end(args);

    return true;
}

/**
* @param outputfile - The full path to the file to write with command output.  
*   This file will be closed at completion of the function call.
* @param count -The numbers of variables passed to the function. 
*   The variables are command to execute and arguments to the command. 
*   Since exec() does not perform path expansion, the first argument needs to be
*   the full path to the command
* @param ... - A list of 0 or more arguments after the @param count function.
*   These will be added to argv[1] and later in the const char * argument
*   to execv (argv[0] will always be the command).
* @return true if the command @param ... with arguments @param arguments 
*   were executed successfully using the system() call, false if an error occurred,
*   either in invocation of the fork, waitpid, or execv() command,
*   or if a non-zero return value was returned by the command issued in 
*   arguments.
*/
bool do_exec_redirect(const char *outputfile, int count, ...)
{
    va_list args;
    va_start(args, count);
    char * command[count+1];
    int i;
    for(i=0; i<count; i++)
    {
        command[i] = va_arg(args, char *);
    }
    command[count] = NULL;

/*
 * TODO
 *   Open the outputfile, fork a child process.
 *   Call execv, but first using https://stackoverflow.com/a/13784315/1446624 as a refernce,
 *   redirect standard out to the outputfile, and rest of the behaviour is same as do_exec()
 *   
*/

    va_end(args);
    
    return true;
}
