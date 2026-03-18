// Perl Weekly Challenge 233 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-233/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void remove_chars(char* str, char ch) {
    char* p;
    while ((p = strchr(str, ch)) != NULL) {
        memmove(p, p+1, strlen(p+1)+1);
    }
}

bool is_similar(const char* a_, const char* b_) {
    char* a = xstrdup(a_);
    char* b = xstrdup(b_);
    while (strlen(a) > 0 && strlen(b) > 0) {
        char ch = a[0];
        remove_chars(a, ch);
        remove_chars(b, ch);
    }
    bool similar = strlen(a)==0 && strlen(b)==0;
    xfree(a);
    xfree(b);
    return similar;
}

int count_similar(StrArray* words) {
    int count = 0;
    for (int i = 0; i < words->size; i++) {
        for (int j = i+1; j < words->size; j++) {
            if (is_similar(words->data[i], words->data[j]))
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    int count = count_similar(words);
    printf("%d\n", count);

    strarray_free(words);
}
