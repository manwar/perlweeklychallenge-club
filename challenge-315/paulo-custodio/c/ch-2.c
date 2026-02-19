#include "alloc.h"

StrArray* parse_words() {
    char line[BUFSIZ];
    StrArray* words = strarray_new();
    if (!fgets(line, sizeof(line), stdin))
        return words;
    const char* separators = " ,.\t\r\n";
    char* p = strtok(line, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    return words;
}

Str* parse_word() {
    StrArray* words = parse_words();
    Str* word = str_new();
    if (words->size > 0)
        str_append(word, words->data[0]);
    strarray_free(words);
    return word;
}

StrArray* find_third(StrArray* words, const char* word1, const char* word2) {
    StrArray* third = strarray_new();
    for (int i = 0; i + 2 < words->size; i++) {
        if (strcmp(words->data[i], word1) == 0 &&
            strcmp(words->data[i+1], word2) == 0) {
            strarray_push_back(third, words->data[i+2]);
        }
    }
    return third;
}

int main() {
    StrArray* words = parse_words();
    Str* word1 = parse_word();
    Str* word2 = parse_word();
    StrArray* third = find_third(words, word1->body, word2->body);
    strarray_print(third);
    strarray_free(words);
    strarray_free(third);
    str_free(word1);
    str_free(word2);
}
