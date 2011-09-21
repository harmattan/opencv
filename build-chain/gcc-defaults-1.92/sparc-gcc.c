#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <sys/utsname.h>

#ifndef GCC_NAME
#error GCC_NAME must be defined
#endif

#define __stringify_1(x)	#x
#define stringify(x)		__stringify_1(x)

#define GCC_EXEC		stringify(GCC_NAME)

#define M64_TEST		"/usr/lib64/libc.so"
#define M64_OVERRIDE		"/etc/disable_64_gcc"
#define ARG_m64			"-m64"
#define ARG_m32			"-m32"

int main(int argc, char *argv[])
{
	int hardwired = 0, i;
	char **newargv;

	/* 2 extra. One for the trailing NULL, the other for possibly
	 * adding -m32 or -m64. */
	newargv = malloc(sizeof(char *) * (argc + 2));
	if (newargv == NULL) {
		perror(GCC_EXEC);
		exit(1);
	}

	for (i = 0; i < argc; i++) {
		if (!strcmp(argv[i], ARG_m32) || !strcmp(argv[i], ARG_m64))
			hardwired = 1;

		newargv[i] = argv[i];
	}

	if (!hardwired) {
		struct utsname uts;
		struct stat st;

		uname(&uts);

		/* The compiler defaults to -m32, so we don't need to add
		 * that. I hope. */
		if (!strcmp("sparc64", uts.machine) && !stat(M64_TEST, &st) && stat(M64_OVERRIDE, &st))
			newargv[i++] = ARG_m64;
	}

	newargv[i] = NULL;

	execv("/usr/bin/" GCC_EXEC, newargv);

	perror(GCC_EXEC);

	exit(1);
}
