// Perl Weekly Challenge 234 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-234/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* common_letters(StrArray* words) {
    Str* common = str_new();
    if (words->size == 0) {
        return common;
    }
    else if (words->size == 1) {
        str_append(common, words->data[0]);
        return common;
    }

    for (int i = 0; i < strlen(words->data[0]); i++) {
        char ch = words->data[0][i];

        // count usage of ch in words 1..N and remove it
        int count = 1;
        for (int j = 1; j < words->size; j++) {
            char* p = strchr(words->data[j], ch);
            if (p != NULL) {
                count++;
                memmove(p, p+1, strlen(p+1)+1);
            }
        }

        if (count == words->size) {
            if (common->size > 0)
                str_append(common, " ");
            str_printf(common, "%c", ch);
        }
    }

    return common;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    Str* common = common_letters(words);
    printf("%s\n", common->body);

    strarray_free(words);
    str_free(common);
}
