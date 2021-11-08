# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

typedef unsigned int number;

number * shortest_path (number ** matrix, number size, number from, number to, 
                        bool * exclude, int exclude_size) {
    if (exclude_size + 1 == size) {
        number * result;
        if ((result = (number *) malloc (3 * sizeof (number))) == NULL) {
            perror ("Malloc result failed");
            exit (1);
        }
        result [0] = 1;
        result [1] = matrix [from] [to];
        result [2] = to;
        return result;
    }

    number * shortest_result;
    bool * new_exclude;
    if ((new_exclude = (bool *) malloc (size * sizeof (bool))) == NULL) {
        perror ("Malloc new_exclude failed");
        exit (1);
    }
    for (number i = 0; i < size; i ++) {
        new_exclude [i] = exclude [i];
    }
    new_exclude [from] = true;

    if ((shortest_result =
                 (number *) malloc ((2 + size) * sizeof (number))) == NULL) {
        perror ("Malloc shortest_result failed");
        exit (1);
    }
    shortest_result [1] = ~0;
    for (number i = 2; i < size + 2; i ++) {
        shortest_result [i] = -1;
    }

    for (number next = 0; next < size; next ++) {
        if (next == from || next == to || exclude [next]) {
            continue;
        }
        number * result = shortest_path (matrix, size, next, to,
                                         new_exclude, exclude_size + 1);
        if (shortest_result [1] > result [1] + matrix [from] [next]) {
            shortest_result [1] = result [1] + matrix [from] [next];
            shortest_result [2] = next;
            for (number i = 0; i < result [0]; i ++) {
                shortest_result [i + 3] = result [i + 2];
            }
            shortest_result [0] = result [0] + 1;
        }

        free (result);
    }

    return shortest_result;
}


int main (void) {
    char *    line    = NULL;
    size_t    len     = 0;
    number ** matrix;
    bool      first_line = true;

    number size = 0; /* Number of nodes  */
    number row  = 0; /* Count lines/rows */

    while (getline (&line, &len, stdin) != -1) {
        int    offset = 0;
        number distance;
        int    off;
        /*
         * Use the first line to calculate the size
         */
        if (first_line) {
            int    offset = 0;
            number distance;
            int    off;
            while (sscanf (line + offset, "%u%n", &distance, &off) == 1) {
                offset += off;
                size ++;
            }
            if ((matrix = (number **)
                           malloc (size * sizeof (number *))) == NULL) {
                perror ("Malloc matrix failed");
                exit (1);
            }
            first_line = false;
        }
        if ((matrix [row] = (number *)
                             malloc (size * sizeof (number))) == NULL) {
            perror ("Mallocing row failed");
            exit (1);
        }
        int col = 0;
        while (sscanf (line + offset, "%d%n", &distance, &off) == 1) {
            offset += off;
            matrix [row] [col ++] = distance;
        }
        row ++;
    }
    free (line);

    bool * exclude;
    if ((exclude = (bool *) malloc ((size) * sizeof (bool))) == NULL) {
        perror ("Malloc exclude failed");
        exit (1);
    }
    for (number i = 0; i < size; i ++) {
        exclude [i] = false;
    }

    number * result = shortest_path (matrix, size, 0, 0, exclude, 0);

    printf ("%u\n", result [1]);
    printf ("0");
    for (number i = 0; i < result [0]; i ++) {
        printf (" %u", result [i + 2]);
    }
    printf ("\n");

    free (matrix);
    free (result);
    free (exclude);

    return (0);
}
