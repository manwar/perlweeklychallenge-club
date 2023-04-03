/*
Challenge 013

Challenge #2
Write a script to demonstrate Mutually Recursive methods. Two methods are
mutually recursive if the first method calls the second and the second calls
first in turn. Using the mutually recursive methods, generate Hofstadter
Female and Male sequences.

 F ( 0 ) = 1   ;   M ( 0 ) = 0
 F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
 M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.
*/

#include <stdio.h>
#include <stdlib.h>

int M(int n);

int F(int n) {
    if (n == 0) return 1;
    return n - M( F(n - 1) );
}

int M(int n) {
    if (n == 0) return 0;
    return n - F( M(n - 1) );
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 N", stderr);
        return EXIT_FAILURE;
    }

    int N = atoi(argv[1]);
    const char* sep = "";
    printf("F: ");
    for (int n = 0; n < N; n++) {
        printf("%s%d", sep, F(n));
        sep = ", ";
    }
    printf(", ...\n");

    sep = "";
    printf("M: ");
    for (int n = 0; n < N; n++) {
        printf("%s%d", sep, M(n));
        sep = ", ";
    }
    printf(", ...\n");
}
