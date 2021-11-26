# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*
 * Given a decimal number, return its binary representation
 */
char * dec2bin (long dec) {
    char * bin;
    if ((bin = (char *) malloc (32 * sizeof (char))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    if (dec == 0) {     /* Special case dec == 0 */
        bin [0] =  '0';
        bin [1] = '\0';
        return (bin);
    }
    size_t i =  0;
    while (dec) {
        bin [i ++] = '0' + dec % 2;
        dec /= 2;
    }
    /*
     * Reverse the string
     */
    for (size_t j = 0; j < i / 2; j ++) {
        char t = bin [j];
        bin [j] = bin [i - j - 1];
        bin [i - j - 1] = t;
    }

    bin [i] = '\0';
    return (bin);
}


int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * end_ptr;
        long a = strtol (line, &end_ptr, 2);
        long b = strtol (end_ptr,  NULL, 2);
        char * bin = dec2bin (a + b);
        printf ("%s\n", bin);
        free (bin);
    }
    free (line);

    return (0);
}
