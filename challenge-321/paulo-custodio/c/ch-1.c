#include "alloc.h"

int distinct_average(DoubleArray* nums) {
    // sort input
    doublearray_sort(nums);

    // collect averages
    DoubleArray* averages = doublearray_new();

    // take pairs from bottom and top
    int b = 0, t = nums->size-1;
    while (b < t) {
        double average = (nums->data[b] + nums->data[t]) / 2.0;
        int found = doublearray_find_index(averages, average);
        if (found < 0)
            doublearray_push_back(averages, average);
        b++; t--;
    }

    int count = averages->size;
    doublearray_free(averages);
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    DoubleArray* nums = doublearray_new();
    for (int i = 1; i < argc; i++)
        doublearray_push_back(nums, atof(argv[i]));

    int count = distinct_average(nums);
    printf("%d\n", count);

    doublearray_free(nums);
}
