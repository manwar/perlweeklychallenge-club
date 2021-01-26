# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <unistd.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o {-f | -t} < input-file
 *
 *    -f: Translate from base 35 to base 10
 *    -t: Translate to base 35 from base 35
 */

int BASE = 35;

/*
 * Convert from base 35 to base 10
 */
long long from_base (char * number) {
    long long out = 0;
    while (* number) {
        char ch = * number ++;
        int  n  = ch <= '9' ? ch - '0' : ch - 'A' + 10;
        out    *= BASE;
        out    += n;
    }
    return (out);
}

/*
 * Convert to base 35 from base 10
 */
char * to_base (long long number) {
    char * out;
    if ((out = (char *) malloc (64 * sizeof (char))) == NULL) {
        fprintf (stderr, "Out of memory\n");
        exit (1);
    }
    size_t i = 0;
    while (number > 0) {
        int rest = number % BASE;
        out [i ++] = rest < 10 ? '0' + rest
                               : 'A' + rest - 10;
        number = number / BASE;
    }
    out [i] = '\0';

    /*
     * Reverse the string
     */
    for (size_t j = 0; 2 * j < i; j ++) {
        char t          = out [j];
        out [j]         = out [i - j - 1];
        out [i - j - 1] = t;
    }

    return (out);
}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  len     = 0;
    size_t  strlen;

    int do_to_base   = 0;
    int do_from_base = 0;
    char ch;

    /*
     * Parse and validate options
     */
    while ((ch = getopt (argc, argv, "tf")) != -1) {
        switch (ch) {
            case 't':
                do_to_base = 1;
                break;
            case 'f':
                do_from_base = 1;
                break;
        }
    }

    if (do_to_base + do_from_base != 1) {
        fprintf (stderr, "Need exactly one of -f or -t options\n");
        exit (1);
    }

    while ((strlen = getline (&line, &len, stdin)) != -1) {
        line [strlen - 1] = '\0'; /* Chop off newline */
        if (do_from_base) {
            printf ("%lld\n", from_base (line));
        }
        if (do_to_base) {
            char * out = to_base (atoll (line));
            printf ("%s\n", out);
            free (out);
        }
        char * line_ptr = line;
    }
    free (line);

    return (0);
}
