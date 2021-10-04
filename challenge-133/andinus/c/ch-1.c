#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        puts("Usage: ./ch-1 <positive number>");
        exit(0);
    }

    const char *errstr;
    long num = strtonum(argv[1], 1, LONG_MAX, &errstr);
    if (errstr != NULL)
        errx(1, "number is %s: %s", errstr, argv[1]);

    double x = num >> 1;
    for (;;) {
        double x_next = (x + (num / x)) / 2;
        if (x == x_next)
            break;
        x = x_next;
    }
    printf("%f\n", x);
}
