#include "alloc.h"

int count_freq(IntArray* nums, int n) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if (nums->data[i] == n)
            count++;
    }
    return count;
}

int get_max_freq(IntArray* nums) {
    int max_freq = 0;
    for (int i = 0; i < nums->size; i++) {
        int freq = count_freq(nums, nums->data[i]);
        max_freq = MAX(max_freq, freq);
    }
    return max_freq;
}

int count_nums_with_max_freq(IntArray* nums) {
    int max_freq = get_max_freq(nums);
    IntArray* counted = intarray_new();
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (intarray_find_index(counted, n) >= 0)
            continue;   // already counted

        int freq = count_freq(nums, n);
        if (freq == max_freq)
            count++;

        intarray_push_back(counted, n);
    }
    intarray_free(counted);
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_nums_with_max_freq(nums);
    printf("%d\n", count);

    intarray_free(nums);
}
