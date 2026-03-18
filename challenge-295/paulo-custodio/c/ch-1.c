// Perl Weekly Challenge 295 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-295/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int find_prefix(char* word, int count, char* words[]) {
    for (int i = 0; i < count; i++) {
        int len = strlen(words[i]);
        if (len > strlen(word))
            continue;
        if (strncmp(word, words[i], len) == 0)
            return len;
    }
    return 0;
}

bool can_split_word(char* word, int count, char* words[]) {
    char* p = word;
    while (*p != '\0') {
        int len = find_prefix(p, count, words);
        if (len == 0)
            return false;
        p += len;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s joinedword words...\n", argv[0]);

    bool ok = can_split_word(argv[1], argc-2, argv+2);
    printf("%s\n", bool_to_string(ok));
}
