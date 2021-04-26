# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define SIZE 7
typedef int number;

int main (void) {
    number * numbers;
    char *  line    = NULL;
    size_t  len     = 0;

    if ((numbers = (number *) malloc (SIZE * sizeof (number))) == NULL) {
        perror ("Malloc numbers failed");
        exit (1);
    }

    while (getline (&line, &len, stdin) != -1) {
        if (sscanf (line, "%d %d %d %d %d %d %d",      &numbers [0],
                           &numbers [1], &numbers [2], &numbers [3],
                           &numbers [4], &numbers [5], &numbers [6]) != SIZE) {
            continue;
        }

        for (size_t a_i = 0; a_i < SIZE; a_i ++) {
            for (size_t b_i = 0; b_i < SIZE; b_i ++) {
                if (a_i == b_i) {
                    continue;
                }
                number target = numbers [a_i] + numbers [b_i];
                for (size_t c_i = 0; c_i < SIZE; c_i ++) {
                    if (a_i == c_i || b_i == c_i) {
                        continue;
                    }
                    for (size_t d_i = 0; d_i < SIZE; d_i ++) {
                        if (a_i == d_i || b_i == d_i || c_i == d_i ||
                            target != numbers [b_i] + numbers [c_i] +
                                      numbers [d_i]) {
                            continue;
                        }
                        for (size_t e_i = 0; e_i < SIZE; e_i ++) {
                            if (a_i == e_i || b_i == e_i ||
                                c_i == e_i || d_i == e_i) {
                                continue;
                            }
                            for (size_t f_i = 0; f_i < SIZE; f_i ++) {
                                if (a_i == f_i || b_i == f_i ||
                                    c_i == f_i || d_i == f_i ||
                                    e_i == f_i ||
                                    target != numbers [d_i] + numbers [e_i] +
                                              numbers [f_i]) {
                                    continue;
                                }
                                for (size_t g_i = 0; g_i < SIZE; g_i ++) {
                                    if (a_i == g_i || b_i == g_i ||
                                        c_i == g_i || d_i == g_i ||
                                        e_i == g_i || f_i == g_i ||
                                        target != numbers [f_i] +
                                                  numbers [g_i]) {
                                        continue;
                                    }
                                    printf ("%d %d %d %d %d %d %d\n",
                                              numbers [a_i], numbers [b_i],
                                              numbers [c_i], numbers [d_i],
                                              numbers [e_i], numbers [f_i],
                                              numbers [g_i]);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    free (line);

    return (0);
}
