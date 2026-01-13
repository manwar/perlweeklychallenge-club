/*
Challenge 356

Task 1: Kolakoski Sequence
Submitted by: Mohammad Sajid Anwar
You are given an integer, $int > 3.

Write a script to generate the Kolakoski Sequence of given length $int and return the count of 1 in the generated sequence. Please follow the wikipedia page for more informations.

Example 1
Input: $int = 4
Output: 2

(1)(22)(11)(2) => 1221

Example 2
Input: $int = 5
Output: 3

(1)(22)(11)(2)(1) => 12211

Example 3
Input: $int = 6
Output: 3

(1)(22)(11)(2)(1)(22) => 122112

Example 4
Input: $int = 7
Output: 4

(1)(22)(11)(2)(1)(22)(1) => 1221121

Example 5
Input: $int = 8
Output: 4

(1)(22)(11)(2)(1)(22)(1)(22) => 12211212
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_SEQUENCE 1024

void kolakoski(int n,
        int* seq, size_t* seq_num, int* count, size_t* count_num) {
    // init sequence
    *seq_num = 0;
    seq[(*seq_num)++] = 1;
    seq[(*seq_num)++] = 2;
    seq[(*seq_num)++] = 2;

    // init count
    *count_num = 0;
    count[(*count_num)++] = 1;
    count[(*count_num)++] = 2;

    // compute sequence
    for (int i = 3; i <= n; i++) {
        int cnt = seq[i-1];
        int num = 3 - seq[*seq_num-1];
        for (int j = 0; j < cnt; j++) {
            seq[(*seq_num)++] = num;
        }
        count[(*count_num)++] = cnt;
    }
}

int count_ones(int* nums, size_t nums_num) {
    int count = 0;
    for (size_t i = 0; i < nums_num; i++) {
        if (nums[i] == 1)
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("Usage: ch-1 num\n", stderr);
        exit(EXIT_FAILURE);
    }

    int n = atoi(argv[1]);
    int seq[MAX_SEQUENCE];
    size_t seq_num = 0;
    int count[MAX_SEQUENCE];
    size_t count_num = 0;
    kolakoski(n, seq, &seq_num, count, &count_num);
    int ones = count_ones(count, count_num);
    printf("%d\n", ones);
}
