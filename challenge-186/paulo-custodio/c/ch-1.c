// Perl Weekly Challenge 186 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split(const char* text_) {
    char* text = xstrdup(text_);
    StrArray* words = strarray_new();
    char* p = strtok(text, " ");
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, " ");
    }
    xfree(text);
    return words;
}

StrArray* zip(StrArray* a, StrArray* b) {
    StrArray* result = strarray_new();
    for (int i = 0; i < a->size || i < b->size; i++) {
        if (i < a->size)
            strarray_push_back(result, a->data[i]);
        if (i < b->size)
            strarray_push_back(result, b->data[i]);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s 'a b ...' '1 2 ...'", argv[0]);

    StrArray* a = split(argv[1]);
    StrArray* b = split(argv[2]);
    StrArray* zipped = zip(a, b);
    strarray_print(zipped);

    strarray_free(a);
    strarray_free(b);
    strarray_free(zipped);
}
