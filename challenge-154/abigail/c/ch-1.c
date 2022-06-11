# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char * p [24] = {"PERL", "PELR", "PREL", "PRLE", "PLER", "PLRE",
                     "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP",
                     "REPL", "RELP", "RPEL", "RPLE", "RLEP", "RLPE",
                     "LERP", "LEPR", "LREP", "LRPE", "LPER", "LPRE"};
    bool   s [24] = {true, true, true, true, true, true, true, true,
                     true, true, true, true, true, true, true, true,
                     true, true, true, true, true, true, true, true};

    char * line;
    size_t len;

    while (getline (&line, &len, stdin) != -1) {
        for (size_t i = 0; i < 24; i ++) {
            if (strncmp (line, p [i], 4) == 0) {
                s [i] = false;
                break;
            }
        }
    }

    for (size_t i = 0; i < 24; i ++) {
        if (s [i]) {
            printf ("%s\n", p [i]);
        }
    }

    free (line);

    return (0);
}
