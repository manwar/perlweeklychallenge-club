#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc, char *argv[]) {
    if (argc <= 1) {
        puts("Usage: ./ch-1 <numbers>");
        exit(0);
    }

    long sum = 0;
    for (int idx = 1; idx < argc; idx++) {
        int num;
        const char *errstr;
        num = strtonum(argv[idx], INT_MIN, INT_MAX, &errstr);
        if (errstr != NULL)
            errx(1, "number is %s: %s", errstr, argv[idx]);

        sum += num;
        printf("%ld ", sum / idx);
    }
    printf("\n");
}
