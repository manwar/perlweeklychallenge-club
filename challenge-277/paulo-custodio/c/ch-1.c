#include "alloc.h"

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

int count_word(StrArray* words, const char* word) {
    int count = 0;
    for (int i = 0; i < words->size; i++) {
        if (strcmp(words->data[i], word) == 0)
            count++;
    }
    return count;
}

int count_common_words(const char* input) {
    // parse input
    StrArray* sentences = split(input, ",");
    if (sentences->size != 2)
        die("invalid input: %s", input);
    StrArray* words1 = split(sentences->data[0], " ");
    StrArray* words2 = split(sentences->data[1], " ");

    // count common
    int common = 0;
    for (int i = 0; i < words1->size; i++) {
        int count1 = count_word(words1, words1->data[i]);
        int count2 = count_word(words2, words1->data[i]);
        if (count1 == 1 && count2 == 1)
            common++;
    }

    // free data
    strarray_free(sentences);
    strarray_free(words1);
    strarray_free(words2);

    return common;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence1,sentence2", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    int common = count_common_words(args->body);
    printf("%d\n", common);
    str_free(args);
}
