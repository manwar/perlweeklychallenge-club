/*
Challenge 001

Challenge #1
Write a script to replace the character ‘e’ with ‘E’ in the string
‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
is found in the string.
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <memory.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
}

int replace_e(char* text) {
    int count = 0;
    for (int i = 0; i < strlen(text); i++) {
        if (text[i] == 'e') {
            text[i] = 'E';
            count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    char* text = check_mem(strdup(""));
    for (int i = 1; i < argc; i++) {
        text = check_mem(realloc(text, strlen(text)+strlen(argv[i])+2));
        strcat(text, argv[i]);
        strcat(text, " ");
    }
    if (*text)
        text[strlen(text)-1] = '\0';        // remove last space

    int count = replace_e(text);
    printf("%d %s\n", count, text);
    free(text);
}
