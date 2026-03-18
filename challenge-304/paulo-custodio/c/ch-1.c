// Perl Weekly Challenge 304 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-304/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool can_arrange(char* bin, int n) {
    for (int i = 0; i < n; i++) {
        char* p = strstr(bin, "000");
        if (p == NULL)
            return false;
        p[1] = '1';
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s bin n", argv[0]);

    char* bin = xstrdup(argv[1]);
    int n = atoi(argv[2]);
    bool ok = can_arrange(bin, n);
    printf("%s\n", bool_to_string(ok));
    xfree(bin);
}
