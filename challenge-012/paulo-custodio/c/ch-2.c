/*
Challenge 012

Challenge #2
Write a script that finds the common directory path, given a collection of
paths and directory separator. For example, if the following paths are
supplied.
/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e
and the path separator is /. Your script should return /a/b as common
directory path.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* common_path(char sep, char* paths[], int num_paths) {
    const char* p0 = paths[0];
    const char* end_common = paths[0];
    while (true) {
        const char* p1 = strchr(p0, sep);
        if (p1 == NULL)
            p1 = p0 + strlen(p0);
        for (int i = 1; i < num_paths; i++) {
            const char* q0 = paths[i] + (p0 - paths[0]);
            const char* q1 = strchr(q0, sep);
            if (q1 == NULL)
                q1 = q0 + strlen(q0);
            if (q1 - q0 != p1 - p0 ||
                strncmp(paths[0], paths[i], p1 - paths[0]) != 0)
                goto failed;
        }
        end_common = p1;
        p0 = p1 + 1;
    }
failed:
    {
        char* ret = check_mem(strdup(paths[0]));
        ret[end_common - paths[0]] = '\0';          // truncate
        return ret;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 1) {
        fputs("usage: ch-2", stderr);
        return EXIT_FAILURE;
    }

    char line[BUFSIZ];
    if (!gets(line)) {
        fputs("expected separator from input", stderr);
        return EXIT_FAILURE;
    }
    char sep = line[0];

    char** paths = NULL;
    int num_paths = 0;
    while (gets(line)) {
        num_paths++;
        paths = check_mem(realloc(paths, num_paths * sizeof(char**)));
        paths[num_paths - 1] = check_mem(strdup(line));
    }
    if (num_paths == 0) {
        fputs("expected paths from input", stderr);
        return EXIT_FAILURE;
    }

    char* common = common_path(sep, paths, num_paths);
    printf("%s\n", common);

    free(common);
    for (int i = 0; i < num_paths; i++)
        free(paths[i]);
    free(paths);
}
