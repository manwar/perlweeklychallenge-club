// Perl Weekly Challenge 255 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-255/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* extra_letters(const char* text, const char* letters) {
    char* extra = xstrdup(letters);
    for (const char* s = text; *s; s++) {
        char* t = strchr(extra, *s);
        if (t != NULL)
            memmove(t, t+1, strlen(t+1)+1);
    }
    return extra;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s word letters", argv[0]);

    char* extra = extra_letters(argv[1], argv[2]);
    printf("%s\n", extra);
    xfree(extra);
}
