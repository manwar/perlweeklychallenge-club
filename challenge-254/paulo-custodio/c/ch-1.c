// Perl Weekly Challenge 254 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-254/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_power_of_tree(int num) {
    int base = 0;
    while (true) {
        int p = base*base*base;
        if (p == num)
            return true;
        else if (p > num)
            return false;
        base++;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s num", argv[0]);

    bool ok = is_power_of_tree(atoi(argv[1]));
    printf("%s\n", bool_to_string(ok));
}
