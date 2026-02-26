#include "alloc.h"

int hamming_distance(int a, int b) {
    int distance = 0;
    while (a > 0 || b > 0) {
        int bit_a = a & 1;
        int bit_b = b & 1;
        if (bit_a != bit_b)
            distance++;
        a >>= 1;
        b >>= 1;
    }
    return distance;
}

int sum_hamming_distance(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size-1; i++) {
        for (int j = i+1; j < nums->size; j++) {
            sum += hamming_distance(nums->data[i], nums->data[j]);
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = sum_hamming_distance(nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
