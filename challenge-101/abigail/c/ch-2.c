# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

/*
 * See https://stackoverflow.com/questions/2049582/
 */

typedef long double num;

/*
 * This determines on which side of the line through (x1, y1) and
 * (x2, y2) the origin lies. If > 0, then the origin lies to the left
 * of the line, if < 0, the origin lies to the right of the line, if
 * = 0, the origin lies on the line.
 */

num side (num x1, num y1, num x2, num y2) {
    return (y2 - y1) * x2 - (x2 - x1) * y2;
}

int main (void) {
    char *  line = NULL;
    size_t  len  = 0;

    while (getline (&line, &len, stdin) != -1) {
        num x1, y1, x2, y2, x3, y3;
        num s1, s2, s3;
        /*
         * Parse input
         */
        if (sscanf (line, "%Lf %Lf %Lf %Lf %Lf %Lf",
                           &x1, &y1, &x2, &y2, &x3, &y3) != 6) {
            fprintf (stderr, "Could not parse input\n");
            exit (1);
        }

        /*
         * Determine where the origin is relative to the three lines 
         * through the vertices of the triangle. Note we have to go
         * in a specific order through the points. (Either clock wise,
         * or counter clockwise, as long as we're consistent).
         */
        s1 = side (x2, y2, x3, y3);
        s2 = side (x3, y3, x1, y1);
        s3 = side (x1, y1, x2, y2);

        /*
         * If the origin either lies to the left (or on) each of the
         * lines, or to the right (or on) each of the lines, the origin
         * lies inside the triangle. If not, it does not.
         */
        printf ("%d\n", (s1 <= 0 && s2 <= 0 && s3 <= 0) ||
                        (s1 >= 0 && s2 >= 0 && s3 >= 0) ? 1 : 0);
    }
    free (line);

    return (0);
}
