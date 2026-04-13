# include <stdlib.h>
# include <stdio.h>
# include <stdbool.h>
# include <ctype.h>

# define MAX_CHARS 100

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * ptr     = line;
        bool saw_space = false;
        short chars    = 0;
        /*
         * Skip leading spaces, and non letters
         */
        while (* ptr && !isalpha (* ptr)) {ptr ++;}
        /*
         * Print the leading #, and first character
         */
        printf ("#%c", tolower (* ptr ++));
        chars += 2;
        while (* ptr && chars < MAX_CHARS) {
            char ch = * ptr ++;
            if (isspace (ch)) {
                /*
                 * If we saw a space, skip it, but remember we did see it
                 */
                saw_space = true;
                continue;
            }
            if (!isalpha (ch)) {
                /*
                 * If it's not a letter, skip it. Don't modify the
                 * saw_space status
                 */
                continue;
            }
            /*
             * We now have a letter. If we saw a space, print its
             * upper case, else print its lower case.
             * The saw_space status will be turned off
             */
            printf ("%c", saw_space ? toupper (ch) : tolower (ch));
            saw_space = false;
            chars ++;
        }
        printf ("\n");
    }
    free (line);
    exit (0);
}
