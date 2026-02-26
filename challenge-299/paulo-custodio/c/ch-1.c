#include "alloc.h"

StrArray* parse_words() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");
    StrArray* list = strarray_parse_list(line);
    return list;
}

const char* replace_word(StrArray* words, const char* word) {
    for (int i = 0; i < words->size; i++) {
        if (strlen(word) >= strlen(words->data[i]) &&
            strncmp(word, words->data[i], strlen(words->data[i])) == 0)
            return words->data[i];
    }
    return word;
}

StrArray* replace_words(StrArray* words, StrArray* sentence) {
    StrArray* out = strarray_new();
    for (int i = 0; i < sentence->size; i++) {
        strarray_push_back(out, replace_word(words, sentence->data[i]));
    }
    return out;
}

int main() {
    StrArray* words = parse_words();
    StrArray* sentence = parse_words();
    StrArray* result = replace_words(words, sentence);

    for (int i = 0; i < result->size; i++) {
        if (i > 0)
            printf(" ");
        printf("%s", result->data[i]);
    }

    strarray_free(words);
    strarray_free(sentence);
    strarray_free(result);
}
