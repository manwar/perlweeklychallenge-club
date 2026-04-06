// Perl Weekly Challenge 368 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-368/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* remove_digit_max(const char* number_, char digit) {
    char* number = xstrdup(number_);

    // remove leftmost digit followed by a larger digit
    int len = strlen(number);
    for (int i = 0; i+1 < len; i++) {
        if (number[i] == digit && number[i+1] > number[i]) {
            memmove(number+i, number+i+1, strlen(number+i+1)+1);
            return number;
        }
    }

    // remove the rightmost digit
    for (int i = len-1; i >= 0; i--) {
        if (number[i] == digit) {
            memmove(number+i, number+i+1, strlen(number+i+1)+1);
            break;
        }
    }

    return number;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s number digit", argv[0]);

    char* result = remove_digit_max(argv[1], argv[2][0]);
    printf("%s\n", result);
    xfree(result);
}
