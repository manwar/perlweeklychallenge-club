/*
Challenge 008

Challenge #2
Write a function, ‘center’, whose argument is a list of strings, which will
be lines of text. The function should insert spaces at the beginning of the
lines of text so that if they were printed, the text would be centered, and
return the modified lines.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLINE 1024

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void center(int nlines, char* lines[]) {
    int max_len = 0;

    for (int i = 0; i < nlines; i++) {
        int len = strlen(lines[i]);
        if (len > max_len)
            max_len = len;
    }

    for (int i = 0; i < nlines; i++) {
        char buffer[MAXLINE];
        int len = strlen(lines[i]);
        sprintf(buffer, "%*s%s", (max_len - len) / 2, "", lines[i]);
        strcpy(lines[i], buffer);
    }
}

int main(int argc, char* argv[]) {
    argc--; argv++;

    int nlines = argc;
    char** lines = check_mem(malloc(nlines * sizeof(char*)));
    for (int i = 0; i < nlines; i++) {
        lines[i] = check_mem(malloc(MAXLINE));
        strcpy(lines[i], argv[i]);
    }

    center(nlines, lines);

    for (int i = 0; i < nlines; i++)
        printf("%s\n", lines[i]);

    for (int i = 0; i < nlines; i++)
        free(lines[i]);
    free(lines);
}
