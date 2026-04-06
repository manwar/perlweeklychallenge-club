# include <stdlib.h>
# include <stdio.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
         char digit = line [linelen - 2];
         line [linelen - 3] = '\0';
         /*
          * Scan the line. Mark any occurrence of the given digit.
          * Mark the first occurrence of the digit followed by a larger
          * digit - if any
          */
         ssize_t mark_digit        = -1;
         ssize_t mark_digit_larger = -1;
         for (size_t i = 0; line [i]; i ++) {
            char ch = line [i];
            if (ch == digit) {
                mark_digit = i;
                if (line [i + 1] > digit) { /* Does the right thing if
                                               line [i + 1] == '\0' */
                    if (mark_digit_larger < 0) {
                        mark_digit_larger = i;
                    }
                }
            }
         }
         /*
          * Find the position of the digit to be removed
          */
         char remove_index = mark_digit_larger >= 0 ? mark_digit_larger
                                                    : mark_digit;
         /*
          * Move characters after remove_index one to the left, including
          * the NUL character. If the index equals -1, do nothing
          */
         if (remove_index >= 0) {
            for (size_t i = remove_index; i < linelen - 3; i ++) {
                line [i] = line [i + 1];
            }
         }
         /*
          * Print the result
          */
         printf ("%s\n", line);
    }
    exit (0);
}
