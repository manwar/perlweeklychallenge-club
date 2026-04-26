# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>
# include <stdbool.h>
# include <string.h>

# define NUL '\0'

int char_compare (const void * a, const void * b) {
    return (* (char *) a - * (char *) b);
}

bool are_anagrams (char * str1, char * str2) {
    char * c_str1 = NULL;
    char * c_str2 = NULL;

    /*
     * Strings should be of the same length to be anagrams
     */
    ssize_t s_str1 = strlen (str1);
    ssize_t s_str2 = strlen (str2);

    if (s_str1 != s_str2) {
        return (false);
    }

    /*
     * Allocate memory for copies
     */
    if ((c_str1 = (char *) malloc ((s_str1 + 1) * sizeof (char))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    if ((c_str2 = (char *) malloc ((s_str2 + 1) * sizeof (char))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    /*
     * Make copies, as sorting will be done in situ
     */
    strncpy (c_str1, str1, s_str1);
    strncpy (c_str2, str2, s_str2);

    /*
     * Sort the characters in the strings
     */
    qsort (c_str1, s_str1, sizeof (char), char_compare);
    qsort (c_str2, s_str2, sizeof (char), char_compare);

    int r = strncmp (c_str1, c_str2, s_str1);

    /*
     * Free the allocated memory
     */
    free (c_str1);
    free (c_str2);
    
    return r == 0 ? true : false;
}

bool can_scramble (char * input, char * target) {
    ssize_t s_input  = strlen (input);
    ssize_t s_target = strlen (target);
    enum indices {i1, i2, t1, t2, t3, t4};

    /*
     * Cannot scramble if they are not of equal size
     */
    if (s_input != s_target) {
        return false;
    }

    /*
     * If they are the same string, we're done
     */
    if (strncmp (input, target, s_input) == 0) {
        return true;
    }

    /*
     * If they aren't anagrams, we cannot scramble them
     */
    if (!are_anagrams (input, target)) {
        return false;
    }

    /*
     * Allocate memory for the chunks we will be using.
     */
    char ** chunks = NULL;
    if ((chunks = (char **) malloc ((t4 + 1) * sizeof (char *))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }
    for (short i = i1; i <= t4; i ++) {
        if ((chunks [i] = (char *) malloc ((s_input + 1) * sizeof (char)))
                                                          == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
    }

    bool r = false;
    for (ssize_t l = 1; l < s_input && !r; l ++) {
        ssize_t m = s_input - l;
        strncpy (chunks [i1], input,      l); chunks [i1] [l] = NUL;
        strncpy (chunks [i2], input  + l, m); chunks [i2] [m] = NUL;
        strncpy (chunks [t1], target,     l); chunks [t1] [l] = NUL;
        strncpy (chunks [t2], target + l, m); chunks [t2] [m] = NUL;
        strncpy (chunks [t3], target,     m); chunks [t3] [m] = NUL;
        strncpy (chunks [t4], target + m, l); chunks [t4] [l] = NUL;

        if (can_scramble (chunks [i1], chunks [t1]) &&
            can_scramble (chunks [i2], chunks [t2]) ||
            can_scramble (chunks [i1], chunks [t4]) &&
            can_scramble (chunks [i2], chunks [t3])) {
            r = true;
        }
    }

    /*
     * Free used memory
     */
    for (short i = i1; i <= t4; i ++) {
        free (chunks [i]);
    }
    free (chunks);

    return r;
}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        char * input  = line;
        char * target = line;
        line [linelen - 1] = NUL;   /* Remove trailing newline */
        while (!isspace (* target)) {
            target ++;
        }
        while (isspace (* target)) {
            * target ++ = NUL;
        }
        printf ("%s\n", can_scramble (input, target) ? "true" : "false");

    }
    free (line);
    exit (0);
}
