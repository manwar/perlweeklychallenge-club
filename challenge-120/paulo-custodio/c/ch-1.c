/*
Challenge 120

TASK #1 - Swap Odd/Even bits
Submitted by: Mohammad S Anwar
You are given a positive integer $N less than or equal to 255.

Write a script to swap the odd positioned bit with even positioned bit and
print the decimal equivalent of the new binary representation.

Example
Input: $N = 101
Output: 154

Binary representation of the given number is 01 10 01 01.
The new binary representation after the odd/even swap is 10 01 10 10.
The decimal equivalent of 10011010 is 154.

Input: $N = 18
Output: 33

Binary representation of the given number is 00 01 00 10.
The new binary representation after the odd/even swap is 00 10 00 01.
The decimal equivalent of 100001 is 33.
*/

#include <stdio.h>
#include <stdlib.h>

int swap_bits(int n) {
    int out = 0;
    int shift = 0;
    while (n > 0) {
        if ((n & 1) != 0) { out |= 2 << shift; }
        if ((n & 2) != 0) { out |= 1 << shift; }
        n >>= 2;
        shift += 2;
    }
    return out;
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2) n = atoi(argv[1]);
    printf("%d\n", swap_bits(n));
}
