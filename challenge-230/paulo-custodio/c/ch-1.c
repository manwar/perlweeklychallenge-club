// Perl Weekly Challenge 230 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-230/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* split_digits(IntArray* nums) {
    char buffer[32];

    IntArray* digits = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        sprintf(buffer, "%d", nums->data[i]);
        for (const char* p = buffer; *p; p++)
            intarray_push_back(digits, *p - '0');
    }
    return digits;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* digits = split_digits(nums);
    intarray_print(digits);

    intarray_free(nums);
    intarray_free(digits);
}
