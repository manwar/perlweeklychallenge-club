# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */



int substrings (char * n, int m, int prefix, int max) {
    int fc, n_prefix;
    char * tail;
    if (!* n) {
        return prefix > -1 && prefix < max && prefix % m == 0;
    }

    fc       = * n - '0';
    tail     = n + 1;
    n_prefix = 10 * (prefix == -1 ? 0 : prefix) + * n - '0';

    return substrings (tail, m, n_prefix, max) +
           substrings (tail, m,   prefix, max);
}

int main (void) {
    int n, m;
    char * num;
    if ((num = (char *) malloc (32 * sizeof (char))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    while (scanf ("%d %d", &n, &m) == 2) {
        sprintf (num, "%d", n);
        printf ("%d\n", substrings (num, m, -1, n));
    }
    return (0);
}
