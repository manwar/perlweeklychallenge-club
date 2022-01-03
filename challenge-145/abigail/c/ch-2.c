# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int cmp (const void * a, const void * b) {
    return strcmp (* (char **) a, * (char **) b);
}

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        str_len --;  /* Don't care about trailing newline */
        /*
         * If we have a string of all identical characters
         * we have the maximum amount of substrings which
         * are palindromes. For a string of length N, this
         * will be N * (N + 1) / 2 palindromes.
         */
        char ** palindromes;
        size_t p_count = 0;
        if ((palindromes = (char **) malloc (
            (str_len * (str_len + 1) / 2) * sizeof (char *))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }

        for (size_t i = 0; i < str_len; i ++) {
            for (size_t j = i; j < str_len; j ++) {
                /*
                 * Now test whether line [i .. j] is a palindrome
                 */
                bool is_palindrome = true;
                for (size_t k = 0; is_palindrome && i + k < j - k; k ++) {
                    if (line [i + k] != line [j - k]) {
                        is_palindrome = false;
                    }
                }
                if (is_palindrome) {
                    char * palindrome;
                    if ((palindrome = (char *) malloc ((j - i + 2) *
                                               sizeof (char))) == NULL) {
                        perror ("Malloc failed");
                        exit (1);
                    }
                    strncpy (palindrome, line + i, j - i + 1);
                    palindrome [j - i + 1] = '\0';

                    palindromes [p_count ++] = palindrome;
                }
            }
        }

        /*
         * Sort all the palindromes. Once sorted, it's easy to print
         * the uniques once: any unique palindrome is either first,
         * of different then the one before it.
         */
        qsort (palindromes, p_count, sizeof (char *), cmp);
        for (size_t i = 0; i < p_count; i ++) {
            if (i == 0 || strcmp (palindromes [i], palindromes [i - 1])) {
                if (i) {
                    printf (" ");
                }
                printf ("%s", palindromes [i]);
            }
            free (palindromes [i]);
        }
        printf ("\n");

        free (palindromes);
    }

    free (line);
    return (0);
}
