// Perl Weekly Challenge 226 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-226/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    char ch;
    int index;
} CharOrder;

int compare(const void* a, const void* b) {
    return ((CharOrder*)a)->index - ((CharOrder*)b)->index;
}

char* reorder_string(const char* str, IntArray* indices) {
    if (strlen(str) != indices->size)
        die("string and indices must have the same length");

    CharOrder* ch_order = xmalloc(indices->size * sizeof(CharOrder));
    for (int i = 0; i < indices->size; i++) {
        ch_order[i].ch = str[i];
        ch_order[i].index = indices->data[i];
    }

    qsort(ch_order, indices->size, sizeof(CharOrder), compare);

    char* result = xstrdup(str);
    for (int i = 0; i < indices->size; i++) {
        result[i] = ch_order[i].ch;
    }

    xfree(ch_order);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s string indices...", argv[0]);

    const char* str = argv[1];
    IntArray* indices = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(indices, atoi(argv[i]));

    char* result = reorder_string(str, indices);
    printf("%s\n", result);

    intarray_free(indices);
    xfree(result);
}
