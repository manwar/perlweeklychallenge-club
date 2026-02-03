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
