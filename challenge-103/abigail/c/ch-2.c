# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

/*
 * Return a malloced string of the given size, or die with
 * an error message if it fails.
 */
char * malloc_char (size_t size) {
    char * string = (char *) malloc (size * sizeof (char));
    if (string == NULL) {
        perror (NULL);
        exit (1);
    }
    return (string);
}

int main (void) {
    char *  line = NULL;
    size_t  len  = 0;
    size_t  str_len;
    struct  track {
        long long run_time;
        char *    title;
    };

    while ((str_len = getline (&line, &len, stdin)) != -1) {
        long long start_time;
        long long current_time;
        long long time_diff;
        char * file_name = malloc_char (str_len);
        size_t index;
        /*
         * Parse input
         */
        if (sscanf (line, "%lld %lld %s",
                           &start_time, &current_time, file_name) != 3) {
            fprintf (stderr, "Failed to parse input\n");
            exit (1);
        }

        /*
         * Switch to milliseconds
         */
        time_diff = (current_time - start_time) * 1000;

        /*
         * Open the file, and count the number of lines. Then seek back.
         */
        FILE * media_file = fopen (file_name, "r");
        char ch;
        size_t number_of_tracks = 0;
        while ((ch = fgetc (media_file)) != EOF) {
            if (ch == '\n') {
                number_of_tracks ++;
            }
        }

        if (fseek (media_file, 0, SEEK_SET) == -1) {
            perror ("Fseek failed");
            exit (1);
        }

        /*
         * Allocate memory for the track info.
         */
        struct track * tracks = (struct track *)
                      malloc (number_of_tracks * sizeof (struct track));

        if (tracks == NULL) {
            perror ("Mallocing tracks failed");
            exit (1);
        }

        /*
         * Read the file, line by line, and store it on tracks.
         */
        char * mline = NULL;
        size_t mlen = 0;
        size_t slen = 0;
        size_t i    = 0;
        long long total_time = 0;
        while ((slen = getline (&mline, &mlen, media_file)) != -1) {
            long long run_time = atoll (mline);
            char * title = malloc_char (slen);
            strncpy (title, mline, slen);
            while (* title != ',') {
                title ++;
            }
            title ++;
            struct track this_track = {run_time, title};
            tracks [i ++] = this_track;

            total_time += run_time;
        }

        /*
         * Skip complete loops.
         */
        time_diff %= total_time;

        /*
         * Find the right track.
         */
        for (size_t i = 0; i < number_of_tracks; i ++) {
            struct track this_track = tracks [i];
            if (time_diff - this_track . run_time < 0) {
                printf ("%s", this_track . title);
                /*
                 * C uses integer division, which is quite handy here.
                 */
                time_diff  /= 1000;
                int hours   =  time_diff / 3600;
                int minutes = (time_diff % 3600) / 60;
                int seconds =  time_diff         % 60;
                if (hours > 0) {
                    printf ("%02d:%02d:%02d\n", hours, minutes, seconds);
                }
                else {
                    printf (     "%02d:%02d\n",        minutes, seconds);
                }
                break;
            }
            else {
                time_diff -= this_track . run_time;
            }
        }

    }
    free (line);

    return (0);
}
