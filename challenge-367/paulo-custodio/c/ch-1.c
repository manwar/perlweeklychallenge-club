// Perl Weekly Challenge 367 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-367/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* find_last_moveable_one(char* bin) {
    int len = strlen(bin);
    for (int i = len-2; i >= 0; i--) {
        if (bin[i] == '1')
            return &bin[i];
    }
    return NULL;
}

char* make_largest_odd(const char* bin) {
    int len = strlen(bin);
    assert(len > 0 && strchr(bin, '1') != NULL);
    char* result = xstrdup(bin);

    // if last is 0, make it 1 by swapping another 1 with it
    if (result[len-1] == '0') {
        char* p = strchr(result, '1');
        assert(p != NULL);
        SWAP(char, *p, result[len-1]);
    }

    // move all '1's except last to replace all '0' coming before
    char* p1;
    while ((p1 = find_last_moveable_one(result)) != NULL) {
        char* p0 = strchr(result, '0');
        if (p0 == NULL)
            break;      // no zeros to swap
        if (p1 < p0)
            break;      // moving this '1' would make number smaller
        SWAP(char, *p0, *p1);
    }

    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2 || strchr(argv[1], '1') == NULL)
        die("usage: %s bin", argv[0]);

    char* result = make_largest_odd(argv[1]);
    printf("%s\n", result);
    xfree(result);
}
