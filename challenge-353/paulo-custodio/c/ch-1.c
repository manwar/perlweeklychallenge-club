#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(a,b) ((a)>(b)?(a):(b))

int count_words(const char* sentence_) {
    char* sentence = strdup(sentence_);
    assert(sentence != NULL);

    int words = 0;
    char* p = strtok(sentence, " \t");
    while (p != NULL) {
        words++;
        p = strtok(NULL, " \t");
    }
    free(sentence);

    return words;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s senetences...\n", argv[0]);
        return EXIT_FAILURE;
    }

    int max_words = 0;
    for (int i = 1; i < argc; i++) {
        int words = count_words(argv[i]);
        max_words = MAX(max_words, words);
    }

    printf("%d\n", max_words);
}
