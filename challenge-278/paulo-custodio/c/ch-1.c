#include "alloc.h"

typedef struct {
    char* word;
    int weight;
} Word;

int compare(const void* a, const void* b) {
    return ((Word*)a)->weight - ((Word*)b)->weight;
}

char* find_digit(char* str) {
    for (char* p = str; *p; p++) {
        if (isdigit(*p))
            return p;
    }
    return NULL;
}

void sort_words(StrArray* words) {
    // fill weights table
    Word* weights = xmalloc(words->size * sizeof(Word));
    for (int i = 0; i < words->size; i++) {
        // find weight
        char* digit_ptr = find_digit(words->data[i]);
        if (digit_ptr == NULL)
            die("invalid wordN: %s", words->data[i]);
        int weight = atoi(digit_ptr);
        *digit_ptr = '\0';      // remove digit

        // fill weights
        weights[i].word = xstrdup(words->data[i]);
        weights[i].weight = weight;
    }

    // sort weights table
    qsort(weights, words->size, sizeof(Word), compare);

    // replace words by words in weights
    for (int i = 0; i < words->size; i++) {
        xfree(words->data[i]);
        words->data[i] = weights[i].word;   // take pointer ownership
    }

    xfree(weights);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s wordN...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    sort_words(words);

    for (int i = 0; i < words->size; i++) {
        if (i > 0)
            printf(" ");
        printf("%s", words->data[i]);
    }
    printf("\n");
}
