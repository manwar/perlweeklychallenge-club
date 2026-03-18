// Perl Weekly Challenge 255 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-255/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    const char* word;
    int freq;
} Word;

void add_word(const char* word, Word* words, int* size) {
    for (int i = 0; i < *size; i++) {
        if (strcmp(word, words[i].word) == 0) {
            words[i].freq++;
            return;
        }
    }
    int index = *size;
    (*size)++;
    words[index].word = word;   // Note weak pointer
    words[index].freq = 1;
}

int compare(const void* a, const void* b) {
    return ((Word*)a)->freq - ((Word*)b)->freq;
}

char* most_common_word(const char* kill_word, const char* paragraph_) {
    // collect words
    char* paragraph = xstrdup(paragraph_);
    StrArray* word_list = strarray_new();
    char* p = strtok(paragraph, ",. ");
    while (p != NULL) {
        strarray_push_back(word_list, p);
        p = strtok(NULL, ",. ");
    }
    xfree(paragraph);

    // collect frequencies
    Word* words = xmalloc(word_list->size * sizeof(Word));  // upper bound
    int words_size = 0;
    for (int i = 0; i < word_list->size; i++) {
        const char* word = word_list->data[i];
        if (strcmp(word, kill_word) != 0)
            add_word(word, words, &words_size);
    }

    // sort
    qsort(words, words_size, sizeof(Word), compare);
    char* common = xstrdup( (words_size == 0) ? "" : words[words_size-1].word );

    strarray_free(word_list);
    xfree(words);

    return common;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s kill_word paragraph", argv[0]);

    const char* kill_word = argv[1];
    Str* paragraph = str_new();
    for (int i = 2; i < argc; i++)
        str_printf(paragraph, "%s ", argv[i]);

    char* common = most_common_word(kill_word, paragraph->body);
    printf("%s\n", common);
    xfree(common);
}
