# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*
 * Helper method to allocate memory for a string.
 */
char * malloc_char (size_t size) {
    char * string = (char *) malloc (size * sizeof (char));
    if (string == NULL) {
        perror (NULL);
        exit (1);
    }
    return (string);
}

/*
 * Use a recursive method to see whether a pattern matches a string:
 * ("PPP" is any pattern, possible empty; the string is of the form
 *  "sSSS" (if non-empty), where "s" is any single character, and "SSS"
 *  a possible empty substring).
 *
 *    - If both the string and pattern are empty, the match succeeds.
 *    - If the string is empty:  
 *         o If the pattern is of the form "*PPP", the result is the
 *           match of the string against "PPP"
 *         o Else, the match fails.
 *    - If pattern is the form "*PPP":
 *         o if the pattern is "*", the match succeeds.
 *         o if the pattern is of the form "**PPP", the result is the match
 *           of the  string against "*PPP".
 *         o if "SSS" (that is, the string without its leading character)
 *           is matches by the pattern, the match succeeds
 *         o if the pattern is of the form "*sPPP", or "*?PPP" (that is,
 *           the character after the leading * is a ? or the first character
 *           of the string), the results of the match is the match of
 *           "SSS" against "PPP".
 *         o else, the match fails.
 *    - If the string is of the form "sSSS", and the pattern is of the
 *      form "sPPP" or "?PPP", the result of the match is the match of
 *      "SSS" against "PPP".
 *    - Else, the match fails.
 */

bool matches (char * string,  size_t string_len,
              char * pattern, size_t pattern_len) {
    if (pattern_len == 0) {
        /* 
         * If we have exhausted the pattern, we have a match
         * if, and only if, we have exhausted the string.
         */
        return (string_len == 0);
    }
    if (string_len == 0) {
        /* 
         * If we have exhausted the string, then if the pattern
         * starts with '*', we consume the '*' and recurse.
         * Else, the match fails.
         */
        return pattern [0] == '*' ? matches (string,      string_len,
                                             pattern + 1, pattern_len - 1)
                                  : false;
    }

    if (pattern [0] == '*') {
        if (pattern_len == 1) {
            /*
             * If pattern is *, it's match, no matter what is in $string.
             */
            return true;
        }
        if (pattern [1] == '*') {
            /*
             * If pattern starts with '**', consume one '*' and recurse.
             */
            return matches (string,      string_len,
                            pattern + 1, pattern_len - 1);
        }
        if (matches (string + 1, string_len - 1,
                     pattern,    pattern_len)) {
            /*
             * Try matching the first character of $string against '*',
             * and recurse -- if this is a match, return 1.
             */
            return true;
        }
        if (pattern [1] == '?' ||
            pattern [1] == string [0]) {
            /*
             * If the pattern starts with '*?', or '*X', where X is
             * the first character of $string, match the '*' with an
             * empty string, and the ? or X with the first character
             * of $string, and recurse.
             */
            return matches (string  + 1, string_len  - 1,
                            pattern + 2, pattern_len - 2);
        }
        /*
         * Else, it's a failure
         */
        return (false);
    }

    if (pattern [0] == '?' ||
        pattern [0] == string [0]) {
        /*
         * If the first character of $pattern matches the first character
         * of $string, or if the first character of $pattern equals '?',
         * match the first characters, and recurse with the rest.
         */
        return matches (string  + 1, string_len  - 1,
                        pattern + 1, pattern_len - 1);
    }

    /*
     * Else, the match fails.
     */
    return false;
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * string;
        char * pattern;

        string  = malloc_char (str_len);
        pattern = malloc_char (str_len);

        if (sscanf (line, "%s %s", string, pattern) != 2) {
            fprintf (stderr, "Could not parse input\n");
            exit (1);
        }

        printf ("%d\n", matches (string,  strnlen (string,  str_len),
                                 pattern, strnlen (pattern, str_len)) ? 1 : 0);

        free (string);
        free (pattern);
    }

    free (line);

    return (0);
}
