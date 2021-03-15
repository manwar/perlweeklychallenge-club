# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        long long max = atoll (line);
        for (long long base2 = 1; base2 <= max; base2 *= 2) {
            for (long long base3 = base2; base3 <= max; base3 *= 3) {
                for (long long base5 = base3; base5 <= max; base5 *= 5) {
                    printf ("%lld\n", base5);
                }
            }
        }
    }
    free (line);

    return (0);
}
