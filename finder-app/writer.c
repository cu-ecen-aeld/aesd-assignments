#include <stdio.h>
#include <stdint.h>
#include <syslog.h>
#include <errno.h>
#include <string.h>

int main(int argc, char * argv[], char * envp[])
{
	FILE * newFileToWrite;
	size_t rc;
	openlog(NULL, 0, LOG_USER);
	if (argc != 3)
	{
		syslog(LOG_ERR, "Must specify exactly two argument!\n");
		closelog();
		return 1;
	}
	newFileToWrite = fopen(argv[1],"w");
	if (newFileToWrite == NULL || argv[1] == NULL || argv[2] == NULL)
	{
		syslog(LOG_ERR, "Unable to create file %s, %s\n", argv[1], strerror(errno));
		closelog();
		return 1;
	}

	rc = fwrite(argv[2], sizeof(char), strlen(argv[2]), newFileToWrite);
	if (rc != sizeof(char) * strlen(argv[2]))
	{
		syslog(LOG_ERR, "Unable to write string properaly\n");
		closelog();
		fclose(newFileToWrite);
		return 1;
	}	
		

	syslog(LOG_INFO, "Writing %s to %s\n", argv[2], argv[1]);
	closelog();
	fclose(newFileToWrite);

	return 0;
}
