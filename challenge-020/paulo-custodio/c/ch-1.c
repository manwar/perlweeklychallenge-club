/*
Challenge 020

Task #1
Write a script to accept a string from command line and split it on change
of character. For example, if the string is "ABBCDEEF", then it should split
like "A", "BB", "C", "D", "EE", "F".
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 string", stderr);
        return EXIT_FAILURE;
    }

    const char* sep = "";
    const char* p = argv[1];
    while (*p) {
        printf("%s\"", sep);
        char c = *p;
        while (*p == c)
            printf("%c", *p++);
        printf("\"");
        sep = ", ";
    }
}
