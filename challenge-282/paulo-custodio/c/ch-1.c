// Perl Weekly Challenge 282 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* good_integer(const char* num) {
    const char *p = num;
    while (*p) {
        const char* q = p;
        while (*q == *p)
            q++;
        if (q - p == 3)
            return xstrndup(p, q-p);
        p = q;
    }
    return xstrdup("-1");
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s integer", argv[0]);

    char* good = good_integer(argv[1]);
    printf("%s\n", good);

    xfree(good);
}
