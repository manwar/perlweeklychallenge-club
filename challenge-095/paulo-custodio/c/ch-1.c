/*
Challenge 095

TASK #1 › Palindrome Number
Submitted by: Mohammad S Anwar
You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.

Example 1:
Input: 1221
Output: 1
Example 2:
Input: -101
Output: 0, since -101 and 101- are not the same.
Example 3:
Input: 90
Output: 0
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int is_palindrome(int n) {
    // negative numbers are not palindromes
    if (n < 0)
        return 0;

    // find highest power of 10 < n
    int p10 = 1;
    while (n > p10*10)
        p10 *= 10;

    // remove highest and lowest digits until number is <10
    while (n >= 10) {
        if (n % 10 != n / p10)
            return 0;
        n = (n % p10) / 10;     // remove high and low digits
        p10 = p10 / 100;
    }

    // if number is less than 10, it is a palindrome
    return 1;
}

int main(int argc, char* argv[]) {
    if (argc==2)
        printf("%d\n", is_palindrome(atoi(argv[1])));
}
