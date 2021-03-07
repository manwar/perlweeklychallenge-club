# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>
# include <limits.h>
# include <ctype.h>
# include <stdbool.h>

# define NR_OF_LETTERS 26

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o -f FILE < input-file
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
 * Given a bag of letters, and a file name, print out
 * all the words in the file which can be made with the letters
 */
void extract_words (char * file_name, size_t letter_bag [NR_OF_LETTERS]) {
    FILE * fh;
    char *  word = NULL;
    size_t  len  = 0;
    size_t  str_len;
    /*
     * Open the file
     */
    if ((fh = fopen (file_name, "r")) == NULL) {
        perror (NULL);
        exit (1);
    }

    /*
     * Iterate over the file, one word at a time.
     */
    while ((str_len = getline (&word, &len, fh)) != -1) {
        bool   winner = true;
        size_t word_bag [NR_OF_LETTERS];  /* Count letters in each word */

        /*
         * Initialize the bag
         */
        for (size_t i = 0; i < NR_OF_LETTERS; i ++) {
            word_bag [i] = 0;
        }

        /*
         * Iterate over the characters of the word (case insensitively),
         * and count how often they occur. If for a character, we need
         * more than there are in the letter bag, we cannot form the word.
         */
        for (size_t i = 0; i < str_len && winner; i ++) {
            ssize_t index = islower (word [i]) ? word [i] - 'a'
                          : isupper (word [i]) ? word [i] - 'A'
                          : -1;
            /*
             * Set winner to false if we don't have enough letters.
             */
            winner = winner && (index < 0 ||
                                ++ word_bag [index] <= letter_bag [index]);
        }
        if (winner) {
            printf ("%s", word);
        }
    }

    /*
     * Close the file
     */
    if (fclose (fh)) {
        perror (NULL);
        exit (1);
    }

    free (word);

    return;
}

int main (int argc, char ** argv) {
    char *  letters = NULL;
    size_t  len     = 0;
    size_t  str_len;

    int     ch;
    char *  file_name = NULL;

    /*
     * Parse the command line
     */
    while ((ch = getopt (argc, argv, "f:")) != -1) {
        switch (ch) {
            case 'f':
                file_name = malloc_char (PATH_MAX);
                stpncpy (file_name, optarg, PATH_MAX);
                break;
        }
    }
    if (file_name == NULL) {
        fprintf (stderr, "Requires a -f FILE parameter\n");
        exit (1);
    }

    /*
     * Read lines of input; each line is a letter set.
     * Iterate over the letters, and count them, ingoring case.
     * Then call method to extract the right words
     */
    while ((str_len = getline (&letters, &len, stdin)) != -1) {
        size_t letter_bag [NR_OF_LETTERS];
        for (size_t i = 0; i < NR_OF_LETTERS; i ++) {
            letter_bag [i] = 0;
        }
        for (size_t i = 0; i < str_len; i ++) {
            if (islower (letters [i])) {
                letter_bag [letters [i] - 'a'] ++;
            }
            if (isupper (letters [i])) {
                letter_bag [letters [i] - 'A'] ++;
            }
        }
        extract_words (file_name, letter_bag);
    }

    free (letters);
    free (file_name);

    return (0);
}
