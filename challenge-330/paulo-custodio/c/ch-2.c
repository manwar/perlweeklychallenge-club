// Perl Weekly Challenge 330 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-330/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"
#include <ctype.h>

void capitalize_word(char* p) {
    if (strlen(p) <= 2)
        *p++ = tolower(*p);
    else
        *p++ = toupper(*p);

    while (*p)
        *p++ = tolower(*p);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence", argv[0]);

    Str* str = str_new();

    for (int i = 1; i < argc; i++) {
        if (i > 1)
            str_append(str, " ");
        int orig_len = str->size;
        str_append(str, argv[i]);
        capitalize_word(str->body + orig_len);
    }

    printf("%s\n", str->body);
    str_free(str);
}
