# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <ctype.h>
# include <limits.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*
 * Copied from https://gist.github.com/w-vi/7e98342181776162b1a3
 */
char * slurpfile (char * filename) {
    FILE * fp;
    char * source;
    long bufsize;
    size_t len;
    if ((fp = fopen (filename, "r")) == NULL) {
        fprintf (stderr, "Failed to open %s\n", filename);
        exit (1);
    }
    /*
     * Get the size of the file:
     *   - seek to the end of the file
     *   - use ftell to get the offset from the start
     *   - seek back to the beginning
     */
    if (fseek (fp, 0L, SEEK_END) != 0) {
        fprintf (stderr, "seek() failed for %s\n", filename);
        exit (1);
    }
    if ((bufsize = ftell (fp)) == -1) {
        fprintf (stderr, "ftell() failed for %s\n", filename);
        exit (1);
    }
    if (fseek (fp, 0L, SEEK_SET) != 0) {
        fprintf (stderr, "seek() failed for %s\n", filename);
        exit (1);
    }

    /*
     * Allocate memory for content of the file
     */
    if ((source = (char *) malloc (sizeof (char) * (bufsize + 1))) == NULL) {
        fprintf (stderr, "malloc() failed for %s\n", filename);
        exit (1);
    }

    /*
     * And read it in
     */
    if ((len = fread (source, sizeof (char), bufsize, fp)) == 0) {
        fprintf (stderr, "fread() failed for %s\n", filename);
        exit (1);
    }
    source [++ len] = '\0';

    return source;
}

/*
 * Use four arrays:
 *   - filenames:    names of files read
 *   - content:      pointers to content of files read
 *   - content_ptr:  pointers to unreturned content
 *   - content_size: number of characters not returned yet
 */
size_t   read_files   = 0;
char  ** filenames    = NULL;
char  ** content      = NULL;
char  ** content_ptr  = NULL;
size_t * content_size = NULL;

char * readN (char * filename, int amount) {
    ssize_t found = -1;
    char * out;
    /*
     * Check whether we've already found the file --
     * if so, set its position in "found".
     */
    for (size_t i = 0; i < read_files; i ++) {
        if (strncmp (filename, filenames [i], PATH_MAX) == 0) {
            /*
             * Found the file
             */
            found = i;
            break;
        }
    }

    /*
     * Not found; all filename, content of file, and size to
     * the end of the arrays.
     */
    if (found < 0) {
        found = read_files ++;
        /*
         * Allocate memory
         */
        if ((filenames = (char **)
                realloc (filenames,    read_files * sizeof (char *))) == NULL) {
            fprintf (stderr, "malloc() failed for %s\n", filename);
            exit (1);
        }
        if ((content = (char **)
                realloc (content,      read_files * sizeof (char *))) == NULL) {
            fprintf (stderr, "malloc() failed for %s\n", filename);
            exit (1);
        }
        if ((content_ptr = (char **)
                realloc (content_ptr,  read_files * sizeof (char *))) == NULL) {
            fprintf (stderr, "malloc() failed for %s\n", filename);
            exit (1);
        }
        if ((content_size = (size_t *)
                realloc (content_size, read_files * sizeof (size_t))) == NULL) {
            fprintf (stderr, "malloc() failed for %s\n", filename);
            exit (1);
        }

        /*
         * Set data
         */
        if ((filenames [found] = (char *)
                    malloc (sizeof (char) * (strlen (filename) + 1))) == NULL) {
            fprintf (stderr, "malloc() failed for %s\n", filename);
            exit (1);
        }
        stpncpy (filenames [found], filename, strlen (filename));
        filenames [found] [strlen (filename)] = '\0';
        content      [found] = slurpfile (filename);
        content_ptr  [found] = content [found];
        content_size [found] = strlen (content [found]);

        /*
         * Remove any trailing new lines
         */
        while (content [found] [content_size [found] - 1] == '\n') {
            content [found] [-- content_size [found]] = '\0';
        }
    }
    /*
     * Now 'found' points to the place where the content
     * of the file is.
     */

     /*
      * Cannot return more than we have.
      */
     if (content_size [found] < amount) {
        amount = content_size [found];
     }
     /*
      * Allocate memory for the return value
      */
     if ((out = (char *) malloc (sizeof (char) * (amount + 1))) == NULL) {
        fprintf (stderr, "malloc() failed for %s\n", filename);
        exit (1);
    }
    /*
     * Copy the amount of data, make sure it's NUL terminated.
     */
    stpncpy (out, content_ptr [found], amount);
    out [amount] = '\0';

    /*
     * Adjust the pointer and size left
     */
    content_ptr  [found] += amount;
    content_size [found] -= amount;

    return out;
}



int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    /*
     * Iterate over the lines of input; parse each line into
     * a file name and an amount. Call readN for each line.
     */
    while ((strlen = getline (&line, &len, stdin)) != -1) {
        char * line_ptr = line;
        char * filename;
        int amount;
        if ((filename = (char *) malloc (PATH_MAX * sizeof (char))) == NULL) {
            fprintf (stderr, "malloc() failed\n");
            exit (1);
        }
        if (sscanf (line_ptr, "%s %d", filename, &amount) != 2) {
            fprintf (stderr, "Could not parse input\n");
            exit (1);
        }
        printf ("%s\n", readN (filename, amount));
        free (filename);
    }
    /*
     * Release memory
     */
    free (line);
    for (size_t i = 0; i < read_files; i ++) {
        free (filenames [i]);
        free (content   [i]);
    }
    free (filenames);
    free (content);
    free (content_ptr);
    free (content_size);

    return (0);
}
