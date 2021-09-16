# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int cmp (const void * a, const void * b) {
    return (* (int *) a - * (int *) b);
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        int offset = 0;
        int count  = 0;
        int number;
        while (sscanf (line_ptr, "%d%n", &number, &offset) == 1) {
            count ++;
            line_ptr += offset;
        }
        int * numbers;
        if ((numbers = (int *) malloc (count * sizeof (int))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        line_ptr = line;
        count = 0;
        while (sscanf (line_ptr, "%d%n", &numbers [count], &offset) == 1) {
            count ++;
            line_ptr += offset;
        }

        qsort (numbers, count, sizeof (int), cmp);

        int found = 0;
        for (int i = 0; i < count - 1; i += 2) {
            if (numbers [i] != numbers [i + 1]) {
                printf ("%d\n", numbers [i]);
                found ++;
            }
        }
        if (!found) { /* Must be last element */
            printf ("%d\n", numbers [count - 1]);
        }
    }
    free (line);

    return (0);
}
