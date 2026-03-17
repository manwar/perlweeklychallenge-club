// Perl Weekly Challenge 330 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-330/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"
#include <ctype.h>

void remove_digits(char* str) {
    int write = 0;
    for (int read = 0; str[read] != '\0'; read++) {
        if (isdigit(str[read])) {
            if (write > 0)
                write--;        // remove previous char
        }
        else {
            str[write++] = str[read];
        }
    }
    str[write] = '\0';
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[1]);

    char* str = xstrdup(argv[1]);
    remove_digits(str);
    printf("%s\n", str);
    free(str);
}
