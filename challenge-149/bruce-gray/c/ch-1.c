#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int
is_fibonacci(const int a) {
    // The maximum digit sum of a 64-bit int is 171,
    // so Fibonacci 233 and higher are not needed.
    return (a ==  0 || a ==  1 || a ==  2 || a ==  3 || a ==  5 || a ==  8
         || a == 13 || a == 21 || a == 34 || a == 55 || a == 89 || a ==144)
        ? 1 : 0;
}

int
sum_of_digits(int a) {
    int sum = 0;
    int digit;

    while (a) {
        digit = a % 10;
        sum  += digit;
        a    -= digit;
        a    /= 10;
    }

    return sum;
}

int
main(int argc, char **argv) {
    assert(argc == 2);
    int count;
    int i;

    if (argv[1][0] == 'b') {
        // Exactly reproduce https://oeis.org/A028840/b028840.txt
        for (i = 0, count = 1 ; count <= 10000 ; i++) {
            if ( is_fibonacci(sum_of_digits(i)) ) {
                printf("%d %d\n", count, i);
                count++;
            }
        }
        for (count = 1 ; count < 64 ; count++) {
            printf("\n");
        }
    }
    else {
        // Produce first N values, formated as per Task example.
        for (i = 0, count = atoi(argv[1]) ; count ; i++) {
            if ( is_fibonacci(sum_of_digits(i)) ) {
                count--;
                printf("%d", i);
                if (count)
                    printf(", ");
            }
        }
        printf("\n");
    }
    return 0;
}
