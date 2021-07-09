# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int possibilities (int target, int * coins, int from, int to) {
    if (target == 0) {
        return 1;
    }
    if (target < 0 || from > to) {
        return 0;
    }

    int sum = 0;
    for (int i = 0; i * coins [from] <= target; i ++) {
        sum += possibilities (target - i * coins [from], coins, from + 1, to);
    }

    return sum;
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        int coin;
        int n;
        int offset = 0;
        int c = 0;
        while (sscanf (line + offset, "%d%n", &coin, &n) == 1) {
            offset += n;
            c ++;
        }
        /*
         * Now c will be the amount of integers on the line.
         * We need this to determine the size of the to be
         * allocated array
         */
        int * coins;
        if ((coins = (int *) malloc (c * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        offset = 0;
        c = 0;
        while (sscanf (line + offset, "%d%n", &coin, &n) == 1) {
            offset += n;
            coins [c ++] = coin;  /* If c == 0, it's our target */
        }

        printf ("%d\n", possibilities (coins [0], coins, 1, c - 1));
    }
    free (line);

    return (0);
}
