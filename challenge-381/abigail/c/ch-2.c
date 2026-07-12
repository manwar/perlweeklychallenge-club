# include <stdlib.h>
# include <stdio.h>
# include <inttypes.h>
# include <sys/errno.h>

extern int errno;

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        intmax_t max, min;
        int numbers = 0;
        int min_c   = 0;
        int max_c   = 0;
        char * ptr  = line;
        while (1) {
            errno = 0;
            intmax_t number = strtoimax (ptr, &ptr, 10);
            if (errno == EINVAL) {break;}
            if (errno) {
                perror ("Cannot parse the input");
                exit (1);
            }
            if (!min_c || number < min) {min = number; min_c = 0;}
            if (!max_c || number > max) {max = number; max_c = 0;}
            if (number == min) {min_c ++;}
            if (number == max) {max_c ++;}
            numbers ++;
        }
        printf ("%d\n", numbers - min_c - (min == max ? 0 : max_c));
    }
    free (line);
    exit (0);
}
