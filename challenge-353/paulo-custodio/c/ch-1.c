#include "alloc.h"

int count_words(const char* sentence_) {
    char* sentence = xstrdup(sentence_);

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
    if (argc < 2)
        die("usage: %s sentences...", argv[0]);

    int max_words = 0;
    for (int i = 1; i < argc; i++) {
        int words = count_words(argv[i]);
        max_words = MAX(max_words, words);
    }

    printf("%d\n", max_words);
}
