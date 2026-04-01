// Perl Weekly Challenge 183 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-183/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* remove_duplicates(StrArray* words) {
    StrArray* result = strarray_new();
    for (int i = 0; i < words->size; i++) {
        const char* word = words->data[i];
        if (strarray_find_index(result, word) < 0)
            strarray_push_back(result, word);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s n,n n,n ...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    StrArray* result = remove_duplicates(words);
    printf("(");
    for (int i = 0; i < result->size; i++) {
        if (i > 0) printf(", ");
        printf("[%s]", result->data[i]);
    }
    printf(")\n");

    strarray_free(words);
    strarray_free(result);
}
