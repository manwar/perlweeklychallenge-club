# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <string.h>

# define NUL '\0'

int next (int i, int max) {return (i + 1) % max;}
int prev (int i, int max) {return i ? i - 1 : max - 1;}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /* Count the number of words */
        char * ptr = line;
        int cnt    = 0;
        while (* ptr) {
            if (!isspace (* ptr) && (!* (ptr + 1) || isspace (* (ptr + 1)))) {
                cnt ++;
            }
            ptr ++;
        }
        char ** words;
        char ** diffs;
        /* Allocate space for the words and their diffs */
        if ((words = (char **) malloc (cnt * sizeof (char *))) == NULL  ||
            (diffs = (char **) malloc (cnt * sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        ptr = line;
        for (int i = 0; i < cnt; i ++) {
            words [i] = ptr;
            /* Eat the current word, and the trailing space(s) */
            while (* ptr && !isspace (* ptr)) {ptr ++;}
            while (* ptr &&  isspace (* ptr)) {* ptr = NUL; ptr ++;}
        }

        /* Find the length of the words */
        int length = 0;
        ptr = words [0];
        while (* ptr ++) {length ++;}

        for (int i = 0; i < cnt; i ++) {
            if ((diffs [i] = (char *)
                              malloc ((length + 1) * sizeof (char))) == NULL) {
                perror ("Malloc failed");
                exit (1);
            }
            /* Copy the word, shift so the word starts with 'a' */
            int offset = words [i] [0] - 'a';
            for (int j = 0; j < length; j ++) {
                diffs [i] [j] = words [i] [j] - offset;
            }
            diffs [i] [length] = NUL;
        }

        for (int i = 0; i < cnt; i ++) {
            if (strncmp (diffs [i], diffs [next (i, cnt)], length) &&
                strncmp (diffs [i], diffs [prev (i, cnt)], length)) {
                printf ("%s\n", words [i]);
                break;
            }
        }
    }
    exit (0);
}
