// Perl Weekly Challenge 220 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-220/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void to_lower(char* str) {
    for (char* p = str; *p; p++)
        *p = tolower(*p);
}

bool found_in_all(char ch, StrArray* words) {
    for (int i = 0; i < words->size; i++) {
        if (strchr(words->data[i], ch) == NULL)
            return false;
    }
    return true;
}

int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

char* get_common_chars(StrArray* words) {
    if (words->size == 0)
        return xstrdup("");
    else if (words->size == 1)
        return xstrdup(words->data[0]);

    // convert to lower case
    for (int i = 0; i < words->size; i++)
        to_lower(words->data[i]);

    // get common
    char* common = xmalloc(strlen(words->data[0]) + 1);
    char* p = common;
    for (int i = 0; i < strlen(words->data[0]); i++) {
        if (found_in_all(words->data[0][i], words))
            *p++ = words->data[0][i];
    }
    *p = '\0';

    // sort
    qsort(common, strlen(common), sizeof(char), compare);

    return common;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    char* common = get_common_chars(words);

    for (int i = 0; common[i]; i++) {
        if (i > 0)
            printf(" ");
        printf("%c", common[i]);
    }
    printf("\n");
}
