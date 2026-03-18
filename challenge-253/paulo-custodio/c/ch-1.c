// Perl Weekly Challenge 253 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-253/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split_words(const char* separator_, const char* text_) {
    // add space to the separators
    Str* separators = str_new();
    str_printf(separators, "%s ", separator_);

    // make text writeable
    char* text = xstrdup(text_);

    // collect words
    StrArray* words = strarray_new();
    char* p = strtok(text, separators->body);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators->body);
    }

    str_free(separators);
    xfree(text);

    return words;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s separator text", argv[0]);

    const char* separator = argv[1];
    Str* args = str_new();
    for (int i = 2; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    StrArray* words = split_words(separator, args->body);
    strarray_print(words);

    str_free(args);
    strarray_free(words);
}
