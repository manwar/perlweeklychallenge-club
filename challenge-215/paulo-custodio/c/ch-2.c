// Perl Weekly Challenge 215 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-215/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void keep_only_bin_digits(char* str) {
    int w = 0;
    for (int r = 0; str[r] != '\0'; r++) {
        if (str[r]=='0' || str[r]=='1')
            str[w++] = str[r];
    }
    str[w] = '\0';
}

bool can_place_ones(const char* str_, int count) {
    char* str = xstrdup(str_);
    keep_only_bin_digits(str);

    for (int i = 0; i < count; i++) {
        char* p = strstr(str, "000");
        if (p == NULL) {
            xfree(str);
            return false;
        }
        p[1] = '1';
    }

    xfree(str);
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s 1,0,1,... count", argv[0]);

    bool ok = can_place_ones(argv[1], atoi(argv[2]));
    printf("%d\n", ok);
}
