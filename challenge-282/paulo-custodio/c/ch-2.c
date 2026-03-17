// Perl Weekly Challenge 282 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int key_changes(const char* text) {
    int changes = 0;
    for (int i = 1; i < strlen(text); i++) {
        if (tolower(text[i-1]) != tolower(text[i]))
            changes++;
    }
    return changes;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    int changes = key_changes(argv[1]);
    printf("%d\n", changes);
}
