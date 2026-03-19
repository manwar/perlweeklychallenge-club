// Perl Weekly Challenge 240 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

#include "utarray.h"
#include "utstring.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>

void usage(void) {
    fputs("Usage: ch-1 -str s1 s2 s3 ... -chk check\n", stderr);
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    UT_array* strs;
    utarray_new(strs, &ut_str_icd);

    UT_string* check;
    utstring_new(check);

    UT_string* inits;
    utstring_new(inits);

    // parse args
    int i = 1;
    while (i < argc) {
        if (0 == strcmp(argv[i], "-str")) {
            i++;
            while (i < argc && argv[i][0] != '-') {
                utarray_push_back(strs, &argv[i]);
                i++;
            }
        }
        else if (0 == strcmp(argv[i], "-chk")) {
            i++;
            if (i < argc) {
                utstring_clear(check);
                utstring_printf(check, "%s", argv[i]);
                i++;
            }
        }
        else {
            usage();
        }
    }
    if (utarray_len(strs) == 0 || utstring_len(check) == 0)
        usage();

    // process
    utstring_clear(inits);
    for (size_t i = 0; i < utarray_len(strs); i++) {
        char* str = *(char**)utarray_eltptr(strs, i);
        utstring_printf(inits, "%c", tolower(str[0]));
    }

    for (size_t i = 0; i < utstring_len(check); i++) {
        utstring_body(check)[i] = tolower(utstring_body(check)[i]);
    }

    if (0 == strcmp(utstring_body(inits), utstring_body(check))) {
        puts("true");
    }
    else {
        puts("false");
    }

    utarray_free(strs);
    utstring_free(check);
    utstring_free(inits);
}
