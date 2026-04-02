// Perl Weekly Challenge 172 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

double median_(DoubleArray* nums, int bot, int top) {
    if (top - bot == 0)
        return 0;
    if (top - bot == 1)
        return nums->data[bot];

    int mid = (top - bot) / 2;
    if ((top - bot) % 2 == 0) {
        return (nums->data[bot+mid-1] + nums->data[bot+mid]) / 2;
    }
    else {
        return nums->data[bot+mid];
    }
}

double median(DoubleArray* nums) {
    return median_(nums, 0, nums->size);
}

double lower_quartile(DoubleArray* nums) {
    return median_(nums, 0, nums->size/2);
}

double upper_quartile(DoubleArray* nums) {
    return median_(nums, nums->size/2, nums->size);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    DoubleArray* nums = doublearray_new();
    for (int i = 1; i < argc; i++)
        doublearray_push_back(nums, atof(argv[i]));

    doublearray_sort(nums);
    printf("(%.1f, %.1f, %.1f, %.1f, %.1f)\n",
            nums->data[0],
            lower_quartile(nums),
            median(nums),
            upper_quartile(nums),
            nums->data[nums->size-1]);
    doublearray_free(nums);
    return 0;
}
