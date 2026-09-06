# include <stdlib.h>
# include <stdio.h>
# include <ctype.h>


int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        /*
         * First pass of the input line. Print the composer. Find the start of
         * notes. Find the start of the positions. Count the number of notes.
         */
        char * note_ptr;
        char * position_ptr;
        char * ptr = line;
        int nr_of_notes = 0;

        /*
         * Composer
         */
        while (isalpha (* ptr)) {printf ("%c", toupper (* ptr ++));}
        printf (" => ");

        /*
         * Skip to the notes
         */
        while (isspace (* ptr)) {ptr ++;}
        note_ptr = ptr;

        /*
         * Skip to the positions
         */
        while (!isdigit (* ptr)) {ptr ++;}
        position_ptr = ptr;

        /*
         * Count the number of positions, which equals the number of notes
         */
        while (* ptr) {
            if (isdigit (* ptr) && !isdigit (* (ptr + 1))) {nr_of_notes ++;}
            ptr ++;
        }

        /*
         * Create an array for the notes
         */
        char ** notes;
        if ((notes = (char **) malloc (nr_of_notes *
                                            sizeof (char *))) == NULL) {
            perror ("Malloc failed!");
            exit (1);
        }
        for (int i = 0; i < nr_of_notes; i ++) {
            if ((notes [i] = (char *) malloc (3 * sizeof (char))) == NULL) {
                perror ("Malloc failed!");
                exit (1);
            }
        }

        /*
         * Parse a position, then use this position to parse the
         * note on the right position
         */
        int position;
        while (sscanf (position_ptr, "%d", &position) == 1) {
            if (sscanf (note_ptr, "%s", notes [position - 1]) != 1) {
                perror ("Cannot parse input");
                exit (1);
            }
            /*
             * Advance the pointers to the next position/note.
             */
            while (!isspace (* position_ptr)) {position_ptr ++;}
            while ( isspace (* position_ptr)) {position_ptr ++;}
            while (!isspace (* note_ptr)) {note_ptr ++;}
            while ( isspace (* note_ptr)) {note_ptr ++;}
        }

        /*
         * Print the notes, and clean up its memory afterwards
         */
        for (int i = 0; i < nr_of_notes; i ++) {
            printf ("%s ", notes [i]);
            free (notes [i]);
        }
        printf ("\n");

        /*
         * Clean up
         */
        free (notes);
    }

    free (line);
    exit (0);
}
