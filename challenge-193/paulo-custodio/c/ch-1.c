// Perl Weekly Challenge 193 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-193/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* dec_to_bin(int n, int width) {
    char* digits = xmalloc(width+1);
    char* p = digits+width;
    *p = '\0';
    for (int i = 0; i < width; i++) {
        int digit = n & 1;
        n >>= 1;
        *--p = digit + '0';
    }
    return digits;
}

StrArray* bin_numbers(int width) {
    StrArray* result = strarray_new();
    int max = 1 << width;
    for (int n = 0; n < max; n++) {
        char* digits = dec_to_bin(n, width);
        strarray_push_back(result, digits);
        xfree(digits);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int width = atoi(argv[1]);
    StrArray* bin_nums = bin_numbers(width);
    strarray_print(bin_nums);
    strarray_free(bin_nums);
}
