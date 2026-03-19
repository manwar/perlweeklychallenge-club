// Perl Weekly Challenge 225 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-225/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define SEPARATORS " .,!?"

int count_words(char* str) {
    int count = 0;
    char* p = strtok(str, SEPARATORS);
    while (p != NULL) {
        count++;
        p = strtok(NULL, SEPARATORS);
    }
    return count;
}

int count_max_words(StrArray* sentences) {
    int max = 0;
    for (int i = 0; i < sentences->size; i++) {
        int count = count_words(sentences->data[i]);
        max = MAX(max, count);
    }
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentences...", argv[0]);

    StrArray* sentences = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(sentences, argv[i]);

    int max = count_max_words(sentences);
    printf("%d\n", max);

    strarray_free(sentences);
}
