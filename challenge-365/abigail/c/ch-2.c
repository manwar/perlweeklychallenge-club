# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <stdbool.h>

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int valids = 0;   /* Number of valid tokes on this line */

        bool is_valid    = true;
        bool in_token    = false;
        bool hyphen_seen = false;

        char * p = line;

        while (* p) {
            char ch   = * p ++;  /* Current character            */
            char n_ch = * p;     /* Next character, might be NUL */
            if (isspace (ch)) {
                if (in_token && is_valid) {
                    valids ++;  /* End of valid token reached */
                }
                in_token    = false;
                is_valid    = true;
                hyphen_seen = false;
                continue;
            }

            if (ch == '-') {
                /*
                 * If we already have seen a hypen in this token,
                 * of the hypen isn't followed by a lower case
                 * letter, the token is false. Also, if we're not inside
                 * a token, it's a leading hypen, invalidating the token.
                 */
                if (hyphen_seen || !in_token || !islower (n_ch)) {
                    is_valid = false;
                }
                in_token    = true;
                hyphen_seen = true;
                continue;
            }

            if (ch == '!' || ch == ',' || ch == '.') {
                /*
                 * Must be followed by a space to make the token valid
                 */
                if (!isspace (n_ch)) {
                    is_valid = false;
                }
                in_token = true;
                continue;
            }

            in_token = true;
            if (!islower (ch)) {
                is_valid = false;
            }
        }

        printf ("%d\n", valids);
    }
    free (line);
    exit (0);
}
