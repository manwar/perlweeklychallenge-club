# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>

/*
 * Given a integer, return the sum of its digits
 */
unsigned digit_sum (unsigned int in) {
    unsigned ds = 0;
    while (in) {
        ds += in % 10;
        in /=      10;
    }
    return (ds);
}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * Parse the input; we'll calculate the first digit sum when
         * parsing over the word, then we'll read in the count.
         */
        char * p = line;
        unsigned int ds = 0;
        while (!isspace (* p)) {
            unsigned char index = * p - 'a' + 1;
            ds += index / 10 + (index % 10);
            p ++;
        }
        int count = atoi (p);
        for (int i = 1; i < count; i ++) {
            /*
             * Repeatedly calculate the digit sum. Won't do anything
             * if the count == 1
             */
            ds = digit_sum (ds);
        }
        /*
         * Print the result
         */
        printf ("%d\n", ds);
    }
    free (line);
    exit (0);
}
