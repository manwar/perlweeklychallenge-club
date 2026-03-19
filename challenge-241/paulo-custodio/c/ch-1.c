// Perl Weekly Challenge 241 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-241/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count_triplets(UT_array* nums, int diff) {
    int count = 0;
    for (size_t i = 0; i < utarray_len(nums) - 2; i++) {
        int ni = *(int*)utarray_eltptr(nums, i);
        for (size_t j = i + 1; j < utarray_len(nums) - 1; j++) {
            int nj = *(int*)utarray_eltptr(nums, j);
            for (size_t k = j + 1; k < utarray_len(nums); k++) {
                int nk = *(int*)utarray_eltptr(nums, k);
                if (nj - ni == diff && nk - nj == diff)
                    count++;
            }
        }
    }
    return count;
}

void usage(void) {
    puts("Usage: ch-1 -nums n n n ... -diff n\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    int diff = -1;

    // parse args
    int i = 1;
    while (i < argc) {
        if (0 == strcmp(argv[i], "-nums")) {
            i++;
            while (i < argc && argv[i][0] != '-') {
                int n = atoi(argv[i]);
                utarray_push_back(nums, &n);
                i++;
            }
        }
        else if (0 == strcmp(argv[i], "-diff")) {
            i++;
            if (i < argc) {
                diff = atoi(argv[i]);
                i++;
            }
        }
        else {
            usage();
        }
    }
    if (utarray_len(nums) == 0 || diff < 0)
        usage();

    // process
    int count = count_triplets(nums, diff);
    printf("%d\n", count);

    utarray_free(nums);
}
