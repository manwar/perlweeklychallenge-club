// Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <memory.h>
#include "utstring.h"

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
    UT_string* text;
    utstring_new(text);

    for (int i = 1; i < argc; i++)
        utstring_printf(text, "%s%s", i==1 ? "" : " ", argv[i]);

    int count = replace_e(utstring_body(text));
    printf("%d %s\n", count, utstring_body(text));

    utstring_free(text);
}
