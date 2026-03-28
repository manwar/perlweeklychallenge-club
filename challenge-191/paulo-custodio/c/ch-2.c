// Perl Weekly Challenge 191 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-191/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_cute_orderings_1(IntArray* prefix, IntArray* pending) {
    if (pending->size == 0)
        return 1;

    int count = 0;
    int div = prefix->size+1;   // next size of prefix
    for (int i = 0; i < pending->size; i++) {
        int n = pending->data[i];
        if (n % div == 0 || div % n == 0) {
            IntArray* copy = intarray_new();
            for (int j = 0; j < pending->size; j++) {
                if (i != j)
                    intarray_push_back(copy, pending->data[j]);
            }

            intarray_push_back(prefix, n);
            count += count_cute_orderings_1(prefix, copy);
            intarray_pop_back(prefix);

            intarray_free(copy);
        }
    }
    return count;
}

int count_cute_orderings(int n) {
    IntArray* prefix = intarray_new();
    IntArray* pending = intarray_new();
    for (int i = 1; i <= n; i++)
        intarray_push_back(pending, i);

    int count = count_cute_orderings_1(prefix, pending);

    intarray_free(prefix);
    intarray_free(pending);

    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    int count = count_cute_orderings(n);
    printf("%d\n", count);
}
