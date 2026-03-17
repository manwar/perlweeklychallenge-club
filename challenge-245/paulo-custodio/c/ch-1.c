// Perl Weekly Challenge 245 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

#include "utarray.h"
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char* name;
    int pop;
} Elem;

UT_icd ut_elem_icd = { sizeof(Elem), NULL, NULL, NULL };

int compare(const void* a_, const void* b_) {
    Elem* a = (Elem*)a_;
    Elem* b = (Elem*)b_;
    return a->pop - b->pop;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-1 lang pop lang pop ...\n", stderr);
        exit(EXIT_FAILURE);
    }

    UT_array* langs;
    utarray_new(langs, &ut_elem_icd);
    for (int i = 1; i + 1 < argc; i += 2) {
        Elem elem;
        elem.name = argv[i];
        elem.pop = atoi(argv[i + 1]);
        utarray_push_back(langs, &elem);
    }

    qsort(utarray_eltptr(langs, 0), utarray_len(langs), sizeof(Elem), compare);

    for (size_t i = 0; i < utarray_len(langs); i++)
        printf("%s ", ((Elem*)utarray_eltptr(langs, i))->name);
    printf("\n");

    utarray_free(langs);
}
