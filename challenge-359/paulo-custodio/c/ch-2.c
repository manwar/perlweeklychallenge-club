// Perl Weekly Challenge 359 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-359/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void remove_duplicates(char* str) {
    int write = 0;
    for (int read = 0; str[read] != '\0'; read++) {
        if (write > 0 && str[write-1] == str[read]) {
            write--;
        }
        else {
            str[write++] = str[read];
        }
    }
    str[write] = '\0';
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s str", argv[0]);

    char* str = xstrdup(argv[1]);
    remove_duplicates(str);
    printf("%s\n", str);
    free(str);
}
