# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */
# define MINUTES_PER_DAY 24 * 60

int main (void) {
    char *  arrival_line   = NULL;
    char *  departure_line = NULL;
    size_t  a_len          = 0;
    size_t  d_len          = 0;
    size_t  a_str_len;
    size_t  d_str_len;

    if ((a_str_len = getline (&arrival_line, &a_len, stdin)) == -1) {
        perror ("Failed to read arrival line");
        exit (1);
    }
    if ((d_str_len = getline (&departure_line, &d_len, stdin)) == -1) {
        perror ("Failed to read departurerrival line");
        exit (1);
    }

    /*
     * Turn any non-digits into spaces.
     */ 
    char * line_ptr = arrival_line;
    while (* line_ptr) {
        if (* line_ptr < '0' || * line_ptr > '9') {
            * line_ptr = ' ';
        }
        line_ptr ++;
    }

    line_ptr = departure_line;
    while (* line_ptr) {
        if (* line_ptr < '0' || * line_ptr > '9') {
            * line_ptr = ' ';
        }
        line_ptr ++;
    }

    /*
     * Initialize the trains array: a counter for every minute in a day
     */
    unsigned int trains [MINUTES_PER_DAY];
    for (size_t i = 0; i < MINUTES_PER_DAY; i ++) {
        trains [i] = 0;
    }

    /*
     * Scan over the arrival/departure times
     */
    int a_hour, a_minute, d_hour, d_minute;
    int a_skip = 0;
    int d_skip = 0;
    char * a_ptr = arrival_line;
    char * d_ptr = departure_line;
    while (sscanf (a_ptr, "%d %d%n", &a_hour, &a_minute, &a_skip) == 2 &&
           sscanf (d_ptr, "%d %d%n", &d_hour, &d_minute, &d_skip) == 2) {
        int arrival   = a_hour * 60 + a_minute;
        int departure = d_hour * 60 + d_minute;
        a_ptr += a_skip;
        d_ptr += d_skip;

        /*
         * Count the number of trains there are in the station for each
         * minute of the day
         */
        for (int i = arrival; i <= departure; i ++) {
            trains [i] ++;
        }
        if (departure < arrival) {
            for (int i = 0; i <= departure; i ++) {
                trains [i] ++;
            }
            for (int i = arrival; i < MINUTES_PER_DAY; i ++) {
                trains [i] ++;
            }
        }
    }

    /*
     * Find the maximum number of trains
     */
    int max = 0;
    for (int i = 0; i < MINUTES_PER_DAY; i ++) {
        if (max < trains [i]) {
            max = trains [i];
        }
    }

    printf ("%d\n", max);

    free (arrival_line);
    free (departure_line);

    return (0);
}
