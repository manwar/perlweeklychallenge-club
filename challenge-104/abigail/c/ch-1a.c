# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1a.o ch-1a.c; ./ch-1a.o
 */

# define MAX 50

typedef long long number;
number  cache [MAX];

/*
 * Fusc sequence is defined as:
 *            ( n,                                        0 <= n <= 1
 * fusc (n) = { fusc  (n / 2),                            n > 1 && n even
 *            ( fusc ((n - 1) / 2) + fusc ((n + 1) / 2),  n > 1 && n odd
 */

number fusc (size_t n) {
    if (cache [n] > -1) {
        return cache [n];
    }
    cache [n] = n % 2 ? fusc ((n - 1) / 2) + fusc ((n + 1) / 2)
                      : fusc ( n      / 2);
    return cache [n];
}

int main (void) {
    /*
     * Initialize the cache
     */
    for (size_t i = 0; i < MAX; i ++) {
        cache [i] = -1;
    }
    cache [0] = 0;
    cache [1] = 1;

    /*
     * Calculate the values and print them.
     */
    for (size_t i = 0; i < MAX; i ++) {
        printf ("%s%lld", i == 0 ? "" : " ", fusc (i));
    }

    printf ("\n");

    return (0);
}
