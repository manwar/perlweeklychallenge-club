# include <stdlib.h>
# include <stdio.h>
# include <string.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char unsigned h_times = 0;
        char unsigned m_times = 0;
        size_t len = strnlen (line, 6);

        if (len == 6 && line [2] == ':') {
            char h1 = line [0];
            char h2 = line [1];
            char m1 = line [3];
            char m2 = line [4];

            /*
             * Calculate the number of possible hours
             */
            if (h1 == '?') {
                h_times =              h2 == '?' ? 24
                        : '0' <= h2 && h2 <= '3' ?  3
                        : '4' <= h2 && h2 <= '9' ?  2
                        :                           0;
            }
            else if (h2 == '?') {
                h_times = '0' <= h1 && h1 <= '1' ? 10
                        :              h1 == '2' ?  4
                        :                           0;
            }
            else if (((h1 == '0' || h1 == '1') && '0' <= h2 && h2 <= '9') ||
                      (h2 == '2'               && '0' <= h2 && h2 <= '3')) {
                h_times = 1;
            }

            /*
             * Calculate the number of possible minutes
             */
            if (m1 == '?') {
                m_times =              m2 == '?' ? 60
                        : '0' <= m2 && m2 <= '9' ?  6
                        :                           0;
            }
            else if ('0' <= m1 && m1 <= '5') {
                m_times =              m2 == '?' ? 10
                        : '0' <= m2 && m2 <= '9' ?  1
                        :                           0;
            }
        }
        printf ("%d\n", h_times * m_times);
    }
    exit (0);
}
