// Perl Weekly Challenge 240 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-2 n n n ...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* old;
    utarray_new(old, &ut_int_icd);

    UT_array* new;
    utarray_new(new, &ut_int_icd);

    // parse args
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        utarray_push_back(old, &n);
    }

    // process
    for (size_t i = 0; i < utarray_len(old); i++) {
        int* old_p = (int*)utarray_eltptr(old, 0);
        int n = old_p[old_p[i]];
        utarray_push_back(new, &n);
    }

    // output
    const char* sep = "";
    for (size_t i = 0; i < utarray_len(new); i++) {
        printf("%s%d", sep, *(int*)utarray_eltptr(new, i));
        sep = " ";
    }
    printf("\n");

    utarray_free(old);
    utarray_free(new);
}
