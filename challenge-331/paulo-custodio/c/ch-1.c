// Perl Weekly Challenge 331 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-331/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define SEPARATORS " \t\r\n\v\f"

int len_last_word() {
    int last_len = 0;
    char line [BUFSIZ];
    while (fgets(line, sizeof(line), stdin) != NULL) {
        char* p = strtok(line, SEPARATORS);
        while (p != NULL) {
            int len = strlen(p);
            if (len > 0)
                last_len = len;

            p = strtok(NULL, SEPARATORS);
        }
    }
    return last_len;
}

int main() {
    int last_len = len_last_word();
    printf("%d\n", last_len);
}
