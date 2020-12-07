# include <stdio.h>
# include <stdlib.h>
# include <string.h>

/*
 * For challenge description, see ../perl/ch-2.pl
 */

char * tick = "\xE2\x9C\x93";   /* UTF-8 bytes for check mark */

/*
 * Given a number, return the width if printed as a decimal number.
 */
int width (long long number) {
    char string [32];
    sprintf (string, "%lld", number);
    return ((int) strlen (string));
}

int main () {
    char *  line    = NULL;
    size_t  len     = 0;

    while (getline (&line, &len, stdin) != -1) {
        long long A, B, P;
        if (sscanf (line, "%lld %lld", &A, &B) == 2) {
            /* Product we will be working towards */
            P = A * B;

            /* Find the widths */
            int w_A = width (A);
            int w_P = width (P);

            /* Main loop */
            while (A) {
                printf ("%*lld  %*lld %s\n", w_A, A, w_P, B,
                                               A % 2 ? tick : "");
                A = A / 2;
                B = B * 2;
            }

            /* Print the horizontal bar */
            char line [64];
            sprintf (line, "%*s  %*s +\n", w_A, "", w_P, "");
            for (int i = 0; i < w_P; i ++) {
                line [w_A + 2 + i] = '-';
            }
            printf ("%s", line);

            /* Print the final line with the product */
            printf ("%*s  %*lld\n", w_A, "", w_P, P);
        }
    }
}
