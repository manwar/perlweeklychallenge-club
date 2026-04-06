# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int count_0 = 0;
        int count_1 = 0;
        char * ptr  = line;
        char ch;
        /*
         * Count the number of 0's and 1's
         */
        while ((ch = * ptr ++)) {
            if (ch == '0') {count_0 ++;}
            if (ch == '1') {count_1 ++;}
        }
        /*
         * Print the required 0's and 1's
         */
        for (int i = 2; i <= count_1; i ++) {
            printf ("1");
        }
        for (int i = 1; i <= count_0; i ++) {
            printf ("0");
        }
        printf ("1\n");
    }
    exit (0);
}
