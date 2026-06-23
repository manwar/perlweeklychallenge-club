# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * ptr = line;
        /*
         * Replace letters by digits
         */
        while (* ptr) {
            if (isalpha (* ptr)) {
                * ptr = * ptr - 'a' + '0';
            }
            ptr ++;
        }

        /*
         * Extract numbers from the line
         */
        long n1  = strtol (line, &ptr, 10);
        long n2  = strtol (ptr,  &ptr, 10);
        long sum = strtol (ptr,  &ptr, 10);

        /*
         * Test whether sum equals
         */
        printf (n1 + n2 == sum ? "true\n" : "false\n");
    }
    free (line);
    exit (0);
}
