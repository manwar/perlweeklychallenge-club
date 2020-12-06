/*
    Compile:
    $ gcc ch-1.c

    Test run:
    $ ./a.out 100
    13015
*/

#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }

    return a;
}

int main(int argc, char** argv) {
    int n = 3;
    if (argc != 1) {
        n = atoi(argv[1]);
    }

    int s = 0;
    for (int x = 1; x <= n; x++) {
        for (int y = x + 1; y <= n; y++) {
            s += gcd(x, y);
        }
    }

    printf("%i\n", s);
}
