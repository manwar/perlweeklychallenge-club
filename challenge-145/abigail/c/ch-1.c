# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    char *  line1 = NULL;
    char *  line2 = NULL;
    size_t  len   = 0;
    long long sum = 0;
    long long num1, num2;
    int  skip1, skip2;

    if (getline (&line1, &len, stdin) == -1 ||
        getline (&line2, &len, stdin) == -1) {
        perror ("Failed to read input");
        exit (1);
    }
    while (sscanf (line1, "%lld%n", &num1, &skip1) == 1 &&
           sscanf (line2, "%lld%n", &num2, &skip2) == 1) {
        sum   += num1 * num2;
        line1 += skip1;
        line2 += skip2;
    }
    printf ("%lld\n", sum);

    return (0);
}
