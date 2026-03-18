// Perl Weekly Challenge 248 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-248/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* calc_distance(const char* str, char ch) {
    // initialize all distances with a very large number
    IntArray* dist = intarray_new();
    for (int i = 0; i < strlen(str); i++)
        intarray_push_back(dist, INT_MAX);

    // compute distances to each found ch
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] == ch) {
            for (int j = 0; j < strlen(str); j++) {
                dist->data[j] = MIN(dist->data[j], abs(i-j));
            }
        }
    }

    return dist;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string char", argv[0]);

    IntArray* dist = calc_distance(argv[1], argv[2][0]);
    intarray_print(dist);
    intarray_free(dist);
}
