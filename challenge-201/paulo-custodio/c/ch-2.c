/*
Challenge 201

Task 2: Penny Piles
Submitted by: Robbie Hatley

You are given an integer, $n > 0.

Write a script to determine the number of ways of putting $n pennies in a row
of piles of ascending heights from left to right.
Example

Input: $n = 5
Output: 7

Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:

    1 1 1 1 1
    1 1 1 2
    1 2 2
    1 1 3
    2 3
    1 4
    5
*/

#include <stdio.h>
#include <stdlib.h>

int make_piles1(int prev, int n) {
    int count = 0;
    if (n == 0)
        count++;
    else if (n > 0) {
        int max = (prev < 0) ? n : prev;
        for (int i = 1; i <= max; i++)
            count += make_piles1(i, n-i);
    }
    return count;
}

int make_piles(int n) {
    return make_piles1(-1, n);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 N", stderr);
        exit(EXIT_FAILURE);
    }

    printf("%d\n", make_piles(atoi(argv[1])));
}
