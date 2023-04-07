/*
Challenge 018

Task #1
Write a script that takes 2 or more strings as command line parameters and
print the longest common substring. For example, the longest common substring
of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC” of length 3.
Other common substrings are “A”, “AB”, “B”, “BA”, “BC” and “C”. Please check
this wiki page for details.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "utstring.h"
#include "utarray.h"

int compare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

UT_array* longest_substrs(int count, char* strs[]) {
    UT_array* subs;
    utarray_new(subs, &ut_str_icd);

    size_t longest_len = 0;

    for (const char* p = strs[0]; *p; p++) {                // starting point
        for (size_t len = strlen(p); len > 1; len--) {      // each length
            if (len >= longest_len) {                       // prune search
                UT_string* sub;
                utstring_new(sub);
                utstring_printf(sub, "%-.*s", len, p);

                bool in_all = true;                         // find in all
                for (int i = 1; i < count; i++) {
                    if (strstr(strs[i], utstring_body(sub)) == NULL) {
                        in_all = false;
                        break;
                    }
                }
                if (in_all) {
                    if (len > longest_len) {
                        utarray_clear(subs);
                        char* elt = utstring_body(sub);
                        utarray_push_back(subs, &elt);
                        longest_len = len;
                    }
                    else if (len == longest_len) {
                        char* elt = utstring_body(sub);
                        utarray_push_back(subs, &elt);
                    }
                }

                utstring_free(sub);
            }
        }
    }
    utarray_sort(subs, compare);
    return subs;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("usage: ch-1 strs...", stderr);
        return EXIT_FAILURE;
    }

    UT_array* subs = longest_substrs(argc - 1, argv + 1);
    printf("(");
    for (size_t i = 0; i < utarray_len(subs); i++)
        printf("%s\"%s\"", i == 0 ? "" : ", ", *(char**)utarray_eltptr(subs, i));
    printf(")\n");

    utarray_free(subs);
}
