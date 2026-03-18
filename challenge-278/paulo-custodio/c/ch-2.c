// Perl Weekly Challenge 278 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-278/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

char* reverse_word(const char* str, char ch) {
    char* word = xstrdup(str);
    char* p = strchr(word, ch);
    if (p == NULL)
        return word;

    qsort(word, p - word + 1, sizeof(char), compare);
    return word;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s word ch", argv[0]);

    char* word = reverse_word(argv[1], argv[2][0]);
    printf("%s\n", word);
    xfree(word);
}
