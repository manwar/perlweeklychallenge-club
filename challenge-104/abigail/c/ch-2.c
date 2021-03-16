# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int tokens   = 12;
int max_take =  3;

int main (void) {
    char * line = NULL;
    size_t cap  = 0;

    while (tokens > 0) {
        printf ("How many tokens do you take? (%2d token%s are left) ",
                 tokens, tokens == 1 ? "" : "s");

        if (getline (&line, &cap, stdin) > 0) {
            int take = atoi (line);
            if (1 <= take && take <= max_take) {
                int takes = max_take + 1 - take;
                printf ("Computer takes %d token%s\n",
                         takes, takes == 1 ? "" : "s");
                tokens -= (max_take + 1);
            }
        }
    }

    printf ("Computer wins\n");

    return (0);
}
