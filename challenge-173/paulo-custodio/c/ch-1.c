// Perl Weekly Challenge 173 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_esthetic(int n) {
    char buffer[32];
    sprintf(buffer, "%d", n);
    int len = strlen(buffer);
    for (int i = 0; i < len-1; i++) {
        if (abs(buffer[i] - buffer[i+1]) != 1)
            return false;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    bool ok = is_esthetic(n);
    printf("%d\n", ok);
}
