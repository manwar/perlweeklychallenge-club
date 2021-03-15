# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  str_len;

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        char * ptr = line;

        /*
         * Parse hour and minute from line
         */
        int  hour = atoi (ptr);
        while (isdigit (* ptr)) {
            ptr ++;
        }
        ptr ++;   /* The ':' separating hour and minute */
        int  minute = atoi (ptr);

        /*
         * Advance the pointer to the first character of the
         * AM/PM marker; if there is none, it will point 
         * to the NUL byte. (And * ptr is then false).
         */
        while (* ptr && (isdigit (* ptr) || isspace (* ptr))) {
            ptr ++;
        }

        /*
         * Calculate the new AM/PM marker:
         *   - If there was one, there new one will be empty.
         *   - Else, if the hour is 12 or larger, it's PM
         *   - Else, it's AM
         */
        char * new_ampm = * ptr ? "" : hour >= 12 ? "pm" : "am";

        /*
         * Calculate the new hour:
         *   - we always mod the hour by 12;
         *        this has the effect of making 12 AM (and 12 PM)
         *        equal to 0, and subtracts 12 from time in 24-hour
         *        format, for times after noon.
         *   - if we started from a 24 hour time, and the hour is
         *     now 0, make it 12.
         *   - if we started from PM time, add 12 to the hour.
         */
        hour %= 12;
        if (!* ptr && hour == 0) {
            hour  = 12;
        }
        if (tolower (* ptr) == 'p') {
            hour += 12;
        }
        
        /*
         * Print the result.
         */
        printf ("%02d:%02d%s\n", hour, minute, new_ampm);
    }
    free (line);

    return (0);
}
