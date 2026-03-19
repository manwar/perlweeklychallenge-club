// Perl Weekly Challenge 229 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-229/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define NUM_ARRAYS  3
#define MIN_COUNT   2

StrArray* split_arrays(char* str) {
    StrArray* strs = strarray_new();
    char* p = strtok(str, ",");
    while (p != NULL) {
        strarray_push_back(strs, p);
        p = strtok(NULL, ",");
    }
    return strs;
}

IntArray* split_ints(char* str) {
    IntArray* nums = intarray_new();
    char* p = strtok(str, " ");
    while (p != NULL) {
        intarray_push_back(nums, atoi(p));
        p = strtok(NULL, " ");
    }
    return nums;
}

IntArray* two_out_of_three(char* text) {
    // get strings
    StrArray* strs = split_arrays(text);
    if (strs->size != NUM_ARRAYS)
        die("expected %d arrays, got %d", NUM_ARRAYS, strs->size);

    // convert to integer
    IntArray* arrays[NUM_ARRAYS];
    for (int i = 0; i < NUM_ARRAYS; i++) {
        arrays[i] = split_ints(strs->data[i]);
    }

    // get all unique sorted numbers
    IntArray* uniq = intarray_new();
    for (int i = 0; i < NUM_ARRAYS; i++) {
        for (int j = 0; j < arrays[i]->size; j++) {
            intarray_push_back(uniq, arrays[i]->data[j]);
        }
    }
    intarray_uniq(uniq);

    // produce list of unique numbers that exist in 2 of the arrays
    IntArray* found = intarray_new();
    for (int i = 0; i < uniq->size; i++) {
        int n = uniq->data[i];
        int count = 0;
        for (int j = 0; j < NUM_ARRAYS; j++) {
            IntArray* arr = arrays[j];
            if (intarray_find_index(arr, n) >= 0)
                count++;
        }
        if (count >= MIN_COUNT)
            intarray_push_back(found, n);
    }

    strarray_free(strs);
    for (int i = 0; i < NUM_ARRAYS; i++)
        intarray_free(arrays[i]);
    intarray_free(uniq);

    return found;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums... , nums..., nums...", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);
    IntArray* found = two_out_of_three(args->body);
    intarray_print(found);
    str_free(args);
}
