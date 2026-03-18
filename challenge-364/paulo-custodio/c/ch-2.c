// Perl Weekly Challenge 364 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* decode(const char* str) {
    Str* result = str_new();
    for (const char* p=str; *p; p++) {
        if (strncmp(p, "()", 2) == 0) {
            str_append(result, "o");
            p++;
        }
        else if (strncmp(p, "(al)", 4) == 0) {
            str_append(result, "al");
            p += 3;
        }
        else {
            str_printf(result, "%c", *p);
        }
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc!=2)
        die("usage: %s string", argv[0]);

    Str* decoded = decode(argv[1]);
    printf("%s\n", decoded->body);
    str_free(decoded);
}
