/*
Challenge 017

Task #1
Create a script to demonstrate Ackermann function. The Ackermann function is
defined as below, m and n are positive number:

  A(m, n) = n + 1                  if m = 0
  A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
  A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0

Example expansions as shown in wiki page.

 A(1, 2) = A(0, A(1, 1))
         = A(0, A(0, A(1, 0)))
         = A(0, A(0, A(0, 1)))
         = A(0, A(0, 2))
         = A(0, 3)
         = 4
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int A(int m, int n) {
    if (m==0)
        return n+1;
    else if (m>0 && n==0)
        return A(m-1,1);
    else if (m>0 && n>0)
        return A(m-1, A(m, n-1));
    else {
        assert(0);
        return 0;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fputs("usage: ch-1 m n", stderr);
        return EXIT_FAILURE;
    }

    printf("%d\n", A(atoi(argv[1]), atoi(argv[2])));
}
