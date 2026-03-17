// Perl Weekly Challenge 272 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-272/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int string_score(const char* str) {
    int score = 0;
    for (int i = 1; str[i]; i++) {
        score += abs(str[i] - str[i-1]);
    }
    return score;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    int score = string_score(argv[1]);
    printf("%d\n", score);
}
