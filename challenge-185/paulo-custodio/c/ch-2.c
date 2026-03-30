// Perl Weekly Challenge 185 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-185/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void mask_code(char* code, int num_mask) {
    int count_masked = 0;
    int len = strlen(code);
    for (int i = 0; i < len && count_masked < num_mask; i++) {
        if (isalnum(code[i])) {
            code[i] = 'x';
            count_masked++;
        }
    }
}

void mask_words(StrArray* words, int num_mask) {
    for (int i = 0; i < words->size; i++) {
        mask_code(words->data[i], num_mask);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    mask_words(words, 4);
    for (int i = 0; i < words->size; i++) {
        if (i > 0)
            printf(" ");
        printf("%s", words->data[i]);
    }
    printf("\n");
    strarray_free(words);
}
