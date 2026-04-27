// Perl Weekly Challenge 370 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-370/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    char* word;
    int count;
} Word;

typedef struct {
    Word* data;
    int size;
    int capacity;
} Words;

Words* words_new() {
    int capacity = 8;
    Words* words = xmalloc(sizeof(Words));
    words->data = xmalloc(capacity * sizeof(Word));
    words->size = 0;
    words->capacity = capacity;
    return words;
}

void words_free(Words* words) {
    for (int i = 0; i < words->size; i++) {
        xfree(words->data[i].word);
    }
    xfree(words->data);
    xfree(words);
}

void words_add(Words* words, const char* word) {
    for (int i = 0; i < words->size; i++) {
        if (strcmp(word, words->data[i].word) == 0) {
            words->data[i].count++;
            return;
        }
    }
    
    if (words->size >= words->capacity) {
        words->capacity *= 2;
        words->data = xrealloc(words->data, words->capacity * sizeof(Word));
    }
    
    words->data[words->size].word = xstrdup(word);
    words->data[words->size].count = 1;
    words->size++;
}

void words_erase(Words* words, const char* word) {
    for (int i = 0; i < words->size; i++) {
        if (strcmp(word, words->data[i].word) == 0) {
            xfree(words->data[i].word);
            memmove(&words->data[i], &words->data[i+1], (words->size - (i+1)) * sizeof(Word));
            words->size--;
            return;
        }
    }
}

int compare(const void* a, const void* b) {
    return ((Word*)b)->count - ((Word*)a)->count;
}

void words_sort(Words* words) {
    qsort(words->data, words->size, sizeof(Word), compare);
}

void lower(char* word) {
    for (char* p = word; *p != '\0'; p++)
        *p = tolower(*p);
}

Words* read_words() {
    Words* words = words_new();
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        return words;
    const char* separators = " \t\r\n.,?!:-";
    char* p = strtok(line, separators);
    while (p != NULL) {
        lower(p);
        words_add(words, p);
        p = strtok(NULL, separators);
    }
    return words;
}

Words* read_input() {
    Words* words = read_words();
    Words* kill = read_words();
    for (int i = 0; i < kill->size; i++) {
        words_erase(words, kill->data[i].word);
    }
    words_free(kill);
    return words;
}

char* most_popular() {
    Words* words = read_input();
    if (words->size == 0)
        return xstrdup("");
    words_sort(words);
    char* popular = xstrdup(words->data[0].word);
    words_free(words);
    return popular;
}

int main() {
    char* popular = most_popular();
    printf("%s\n", popular);
    xfree(popular);
}
