#include "alloc.h"

void kolakoski(int n, IntArray* seq, IntArray* count) {
    // init sequence
    intarray_push_back(seq, 1);
    intarray_push_back(seq, 2);
    intarray_push_back(seq, 2);

    // init count
    intarray_push_back(count, 1);
    intarray_push_back(count, 2);

    // compute sequence
    for (int i = 3; i <= n; i++) {
        int cnt = seq->data[i - 1];
        int num = 3 - seq->data[seq->size - 1];
        for (int j = 0; j < cnt; j++) {
            intarray_push_back(seq, num);
        }
        intarray_push_back(count, cnt);
    }
}

int count_ones(IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == 1)
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("Usage: %s num", argv[0]);

    int n = atoi(argv[1]);

    IntArray* seq = intarray_new();
    IntArray* count = intarray_new();

    kolakoski(n, seq, count);
    int ones = count_ones(count);
    printf("%d\n", ones);

    intarray_free(seq);
    intarray_free(count);
}
