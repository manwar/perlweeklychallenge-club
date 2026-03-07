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

int count_word(const char* word, StrArray* words) {
    int count = 0;
    for (int i = 0; i < words->size; i++) {
        if (strcmp(word, words->data[i]) == 0)
            count++;
    }
    return count;
}

StrArray* get_uncommon_words(StrArray* words1, StrArray* words2) {
    StrArray* uncommon = strarray_new();

    for (int i = 0; i < words1->size; i++) {
        const char* word = words1->data[i];
        int count1 = count_word(word, words1);
        int count2 = count_word(word, words2);
        if (count1 == 1 && count2 == 0)
            strarray_push_back(uncommon, word);
    }

    for (int i = 0; i < words2->size; i++) {
        const char* word = words2->data[i];
        int count1 = count_word(word, words1);
        int count2 = count_word(word, words2);
        if (count1 == 0 && count2 == 1)
            strarray_push_back(uncommon, word);
    }

    strarray_sort(uncommon);
    return uncommon;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence1,senetence2", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // get sentences
    StrArray* sentences = split(args->body, ",");
    if (sentences->size != 2)
        die("invalid input: %s", args->body);

    StrArray* words1 = split(sentences->data[0], " ");
    StrArray* words2 = split(sentences->data[1], " ");
    StrArray* uncommon = get_uncommon_words(words1, words2);
    strarray_print(uncommon);

    str_free(args);
    strarray_free(sentences);
    strarray_free(words1);
    strarray_free(words2);
}
