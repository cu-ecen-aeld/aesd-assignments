#include <stdlib.h>
#include <stdint.h> // general use
#include <unistd.h>
#include <signal.h> //
#include <wait.h>   // waitpid()
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "systemcalls.h"

/**
 * @param cmd the command to execute with system()
 * @return true if the command in @param cmd was executed
 *   successfully using the system() call, false if an error occurred,
 *   either in invocation of the system() call, or if a non-zero return
 *   value was returned by the command issued in @param cmd.
*/
bool do_system(const char *cmd)
{

/*
 * TODO  add your code here
 *  Call the system() function with the command set in the cmd
 *   and return a boolean true if the system() call completed with success
 *   or false() if it returned a failure
*/
    int rc = system(cmd);
    if(cmd == NULL && rc == 0)
    {
        return false;
    }
    if (WIFSIGNALED(rc) &&
        (WTERMSIG(rc) == SIGINT || WTERMSIG(rc) == SIGQUIT))
            return false;

    return true;
}

/**
* @param count -The numbers of variables passed to the function. The variables are command to execute.
*   followed by arguments to pass to the command
*   Since exec() does not perform path expansion, the command to execute needs
*   to be an absolute path.
* @param ... - A list of 1 or more arguments after the @param count argument.
*   The first is always the full path to the command to execute with execv()
*   The remaining arguments are a list of arguments to pass to the command in execv()
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
    pid_t cpid, w;
    int wstatus, ret = true;
    for(i=0; i<count; i++)
    {
        command[i] = va_arg(args, char *);
    }
    command[count] = NULL;
/*
 * TODO:
 *   Execute a system command by calling fork, execv(),
 *   and wait instead 
    pid_t childPid;of system (see LSP page 161).
 *   Use the command[0] as the full path to the command to execute
 *   (first argument to execv), and use the remaining arguments
 *   as second argument to the execv() command.
 *
*/
    fflush(stdout);
    cpid = fork();
    if (cpid == -1)
    {
    	perror("fork");
        ret = false;
    } else if (cpid == 0) {            /* Code executed by child */
        printf("Child PID is %jd\n", (intmax_t) getpid());
        if (-1 == execv(command[0], command))
        {
            printf("Unable to run command %s\n", command[0]);
            _exit(1);
        }
        _exit(0);

    } else {                    /* Code executed by parent */
        w = waitpid(cpid, &wstatus, WUNTRACED | WCONTINUED);
        if (w == -1) {
            perror("waitpid");
            ret = false;
        }

        if (WIFEXITED(wstatus)) {
            printf("exited, status=%d\n", WEXITSTATUS(wstatus));
            if (WEXITSTATUS(wstatus) != 0) {
                ret = false;
            }
        } else if (WIFSIGNALED(wstatus)) {
            printf("killed by signal %d\n", WTERMSIG(wstatus));
        } else if (WIFSTOPPED(wstatus)) {
            printf("stopped by signal %d\n", WSTOPSIG(wstatus));
        } else if (WIFCONTINUED(wstatus)) {
            printf("continued\n");
        }
    }

    va_end(args);

    return ret;
}

/**
* @param outputfile - The full path to the file to write with command output.
*   This file will be closed at completion of the function call.
* All other parameters, see do_exec above
*/
bool do_exec_redirect(const char *outputfile, int count, ...)
{
    va_list args;
    va_start(args, count);
    char * command[count+1];
    int i;
    pid_t cpid, w;
    int wstatus, ret = true;
    for(i=0; i<count; i++)
    {
        command[i] = va_arg(args, char *);
    }
    command[count] = NULL;

/*
 * TODO
 *   Call execv, but first using https://stackoverflow.com/a/13784315/1446624 as a refernce,
 *   redirect standard out to a file specified by outputfile.
 *   The rest of the behaviour is same as do_exec()
 *
*/
    fflush(stdout);
    cpid = fork();
    if (cpid == -1)
    {
        perror("fork");
        ret = false;
    } else if (cpid == 0) {            /* Code executed by child */
        int fd;
        fd = open(outputfile, O_WRONLY|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
        if (dup2(fd , 1) < 0)
        {
            perror("dup2 fail");
            _exit(-2);
        }
        if (-1 == execv(command[0], command))
        {
            printf("Unable to run command %s", command[0]);
            _exit(1);
        }
        close(fd);
        _exit(0);

    } else {                    /* Code executed by parent */
        w = waitpid(cpid, &wstatus, WUNTRACED | WCONTINUED);
        if (w == -1) {
            perror("waitpid");
            ret = false;
        }

        if (WIFEXITED(wstatus)) {
            printf("exited, status=%d\n", WEXITSTATUS(wstatus));
            if (WEXITSTATUS(wstatus) != 0) {
                ret = false;
            }
        } else if (WIFSIGNALED(wstatus)) {
            printf("killed by signal %d\n", WTERMSIG(wstatus));
        } else if (WIFSTOPPED(wstatus)) {
            printf("stopped signal %d\n", WSTOPSIG(wstatus));
        } else if (WIFCONTINUED(wstatus)) {
            printf("continued\n");
        }
    }

    va_end(args);

    return ret;
}

/*
int main(int argc, char * argv[], char * envp[])
{
    int ret = true;
    do_system("ls -l");
    do_exec(2, "/bin/ls", "-l");
    do_exec_redirect("tempfile.tmp", 2, "/bin/ls", "-l", "-R");
    return ret;
}
*/
