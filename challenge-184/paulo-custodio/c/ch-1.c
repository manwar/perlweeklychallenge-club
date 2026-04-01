// Perl Weekly Challenge 184 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-184/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void number_sequence(StrArray* words) {
    char buffer[32];
    for (int i = 0; i < words->size; i++) {
        sprintf(buffer, "%02d", i);
        if (strlen(words->data[i]) >= 2)
            memcpy(words->data[i], buffer, 2);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);
    number_sequence(words);
    strarray_print(words);
    strarray_free(words);
}
