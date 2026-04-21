// Perl Weekly Challenge 369 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-369/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split_and_fill(const char* word, int size, char filler) {
    StrArray* words = strarray_new();
    if (strlen(word) == 0)
        return words;

    char* segment = xmalloc(size + 1);
    for (const char* p = word; *p; p += MIN(size, strlen(p))) {
        int segment_size = MIN(size, strlen(p));
        strncpy(segment, p, segment_size);
        for (int j = segment_size; j < size; j++) {
            segment[j] = filler;
        }
        segment[size] = '\0';
        strarray_push_back(words, segment);
    }
    xfree(segment);

    return words;
}

int main(int argc, char* argv[]) {
    if (argc != 4)
        die("usage: %s word size filler", argv[0]);

    StrArray* words = split_and_fill(argv[1], atoi(argv[2]), argv[3][0]);
    if (words->size == 1) {
        printf("\"%s\"\n", words->data[0]);
    }
    else {
        printf("(");
        for (int i = 0; i < words->size; i++) {
            if (i > 0)
                printf(", ");
            printf("\"%s\"", words->data[i]);
        }
        printf(")\n");
    }

    strarray_free(words);
}
