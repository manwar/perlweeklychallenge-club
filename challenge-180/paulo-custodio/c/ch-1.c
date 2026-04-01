// Perl Weekly Challenge 180 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int index_first_uniq_char(const char* str) {
    int freq[256] = {0};

    // compute frequencies
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        int ch = (unsigned char)str[i];
        freq[ch]++;
    }

    // return index of first char with freq 1
    for (int i = 0; i < len; i++) {
        int ch = (unsigned char)str[i];
        if (freq[ch] == 1)
            return i;
    }

    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++) {
        if (args->size > 0)
            str_append(args, " ");
        str_append(args, argv[i]);
    }

    int index = index_first_uniq_char(args->body);
    printf("%d\n", index);

    str_free(args);
}
