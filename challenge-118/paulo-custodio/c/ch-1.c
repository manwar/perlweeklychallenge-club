/*
Challenge 118

TASK #1 - Binary Palindrome
Submitted by : Mohammad S Anwar
You are given a positive integer $N.

Write a script to find out if the binary representation of the given integer
is Palindrome.Print 1 if it is otherwise 0.

Example
Input: $N = 5
Output : 1 as binary representation of 5 is 101 which is Palindrome.

Input : $N = 4
Output : 0 as binary representation of 4 is 100 which is NOT Palindrome.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAXLINE 1024

void int_to_rev_binary(char* buffer, int n) {
    buffer[0] = '\0';
    while (n > 0) {
        strcat(buffer, n & 1 ? "1" : "0");
        n >>= 1;
    }
}

void reverse_string(char* dst, const char* src) {
    int len = strlen(src);
    for (int i = 0; i < len; i++)
        dst[len - 1 - i] = src[i];
    dst[len] = '\0';
}

bool is_palindrome(int n) {
    char n_str[MAXLINE], rev_n_str[MAXLINE];
    int_to_rev_binary(rev_n_str, n);
    reverse_string(n_str, rev_n_str);
    if (strcmp(n_str, rev_n_str) == 0)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2) n = atoi(argv[1]);
    printf("%d\n", is_palindrome(n) ? 1 : 0);
}
