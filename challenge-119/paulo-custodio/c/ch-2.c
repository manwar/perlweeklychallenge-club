/*
Challenge 119

TASK #2 - Sequence without 1-on-1
Submitted by: Cheok-Yin Fung
Write a script to generate sequence starting at 1. Consider the increasing
sequence of integers which contain only 1's, 2's and 3's, and do not have any
doublets of 1's like below. Please accept a positive integer $N and print the
$Nth term in the generated sequence.

1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

Example
Input: $N = 5
Output: 13

Input: $N = 10
Output: 32

Input: $N = 60
Output: 2223
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool num_ok(int n) {
    int last_digit, digit;

    if (n <= 0)
        return false;
    while (n > 0) {
        last_digit = digit;
        digit = n % 10;
        n /= 10;
        if (digit < 1 || digit > 3 || (digit == 1 && last_digit == 1))
            return false;
    }
    return true;
}

int next_seq(int seq) {
    while (1) {
        seq++;
        if (num_ok(seq))
            return seq;
    }
}

int main(int argc, char* argv[]) {
    int num = 0;
    if (argc == 2) num = atoi(argv[1]);

    int seq = 0;
    for (int i = 0; i < num; i++)
        seq = next_seq(seq);

    printf("%d\n", seq);
}
