// Perl Weekly Challenge 217 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-217/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define SEPARATORS " ,[]()"

int third_smallest(char* text) {
    IntArray* nums = intarray_new();
    char* p = strtok(text, SEPARATORS);
    while (p != NULL) {
        intarray_push_back(nums, atoi(p));
        p = strtok(NULL, SEPARATORS);
    }
    intarray_sort(nums);
    int result = nums->size < 3 ? 0 : nums->data[2];
    intarray_free(nums);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s matrix", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);
    int n = third_smallest(args->body);
    printf("%d\n", n);
    str_free(args);
}
