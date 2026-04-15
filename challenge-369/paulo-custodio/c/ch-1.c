// Perl Weekly Challenge 369 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-369/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split_words(char* sentence) {
    const char* separators = " \t\r\n";
    StrArray* words = strarray_new();
    char* p = strtok(sentence, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    return words;
}

void capitalize(char* word) {
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        if (i == 0)
            word[i] = toupper(word[i]);
        else
            word[i] = tolower(word[i]);
    }
}

void lowercase(char* word) {
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        word[i] = tolower(word[i]);
    }
}

void remove_non_letters(char* word) {
    int len = strlen(word);
    int w = 0;
    for (int i = 0; i < len; i++) {
        if (isalpha(word[i]))
            word[w++] = word[i];
    }
    word[w] = '\0';
}

void truncate(char* word, int max_size) {
    int len = strlen(word);
    if (len > max_size)
        word[max_size] = '\0';
}

Str* create_tag(char* sentence) {
    StrArray* words = split_words(sentence);

    Str* tag = str_new();
    str_append(tag, "#");

    for (int i = 0; i < words->size; i++) {
        remove_non_letters(words->data[i]);
        if (i == 0)
            lowercase(words->data[i]);
        else
            capitalize(words->data[i]);

        str_printf(tag, "%s", words->data[i]);
    }

    truncate(tag->body, 100);

    strarray_free(words);
    return tag;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence", argv[0]);

    Str* sentence = str_new();
    for (int i = 1; i < argc; i++) {
        str_printf(sentence, "%s ", argv[i]);
    }

    Str* tag = create_tag(sentence->body);
    printf("%s\n", tag->body);

    str_free(sentence);
    str_free(tag);
}
