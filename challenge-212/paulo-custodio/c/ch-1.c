// Perl Weekly Challenge 212 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-212/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char* jumping_letters(const char* input, IntArray* jumps) {
    char* output = xstrdup(input);
    for (int i = 0; output[i] != '\0'; i++) {
        int jump = (i < jumps->size) ? jumps->data[i] : 0;
        int c = output[i];
        if (c >= 'a' && c <= 'z') {
            c += jump;
            if (c > 'z')
                c -= 26;
        }
        if (c >= 'A' && c <= 'Z') {
            c += jump;
            if (c > 'Z')
                c -= 26;
        }
        output[i] = c;
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s word jumps...", argv[0]);

    const char* word = argv[1];

    IntArray* jumps = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(jumps, atoi(argv[i]));

    char* result = jumping_letters(word, jumps);
    printf("%s\n", result);

    intarray_free(jumps);
    xfree(result);
}
