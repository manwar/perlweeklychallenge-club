# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
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
 * Recursively count matches:
 *   - If either the string or the pattern is empty, there are no matches.
 *   - Else, + count the matches if we don't match at the first character
 *             if the string.
 *           + if the first character of the string equals the first
 *             character of the pattern:
 *             o  add 1 if the pattern is just one character long
 *             o  else, add the number of matches starting from the
 *                then next character in the string, and the next
 *                character in the pattern.
 */
int matches (char * string,  size_t string_len,
             char * pattern, size_t pattern_len) {
    if (string_len == 0 || pattern_len == 0) {
        return 0;
    }

    /*
     * Don't match at the beginning
     */
    int count = matches (string + 1, string_len - 1,
                         pattern,    pattern_len);
    if (string [0] == pattern [0]) {
        if (pattern_len == 1) {
            count ++;
        }
        else {
            count += matches (string  + 1, string_len  - 1,
                              pattern + 1, pattern_len - 1);
        }
    }
    return count;
}


/*
 * Read input from standard input, assuming one exercise per line.
 * Each line consists of a string $S, and a pattern $T, separated
 * by whitespace.
 */
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
                                 pattern, strnlen (pattern, str_len)));

        free (pattern);
        free (string);
    }
    free (line);

    return (0);
}
