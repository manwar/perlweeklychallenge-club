# include <stdlib.h>
# include <stdio.h>
# include <errno.h>
# include <stdbool.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * ptr = line;
        bool first = true;
        errno = 0;
        int p_updown = 1;
        int c_streak = 0;
        int max = 1;
        for (long prev = 0,   cur = strtol (ptr, &ptr, 10); errno == 0;
                  prev = cur, cur = strtol (ptr, &ptr, 10)) {
            if (!first) {
                int c_updown = prev <  cur ? -1
                             : prev == cur ?  0
                             :                1;
                if (c_updown && c_updown == -p_updown) {
                    if (++ c_streak >= max) {
                        max = c_streak + 1;
                    }
                }
                else {
                    c_streak = 1;
                }
                p_updown = c_updown;
            }

            prev  = cur;
            first = false;
        }
        printf ("%d\n", max);
    }
    free (line);
    exit (0);
}
