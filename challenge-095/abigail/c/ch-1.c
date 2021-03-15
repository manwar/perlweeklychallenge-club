# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len = 0;

    /*
     * Check whether a given number is a palindrome. We're only
     * handling numbers consisting of ASCII digits.
     */
    while ((str_len = getline (&line, &len, stdin)) != -1) {
        str_len --;  /* New line */
        bool is_palindrome = !!str_len;

        /*
         * Check wether the characters are digits, and the same
         * when counting from the end. Of strings of uneven length,
         * don't check the middle character just yet.
         */
        for (size_t i = 0; i < str_len / 2 && is_palindrome; i ++) {
            if (line [i] < '0' || line [i] > '9' ||
                line [i] != line [str_len - i - 1]) {
                is_palindrome = false;
            }
        }
        /*
         * If we have an odd number of characters, check whether the middle
         * character is a digit, or a dot -- but if it's a dot, the string
         * should be at least two characters in length.
         */
        if (is_palindrome && str_len % 2) {
            size_t mid = str_len / 2;
            if ((line [mid]  < '0' || line [mid] > '9') && 
                (line [mid] != '.' || str_len == 1)) {
                is_palindrome = false;
            }
        }
        printf ("%d\n", is_palindrome ? 1 : 0);
    }
    free (line);

    return (0);
}
