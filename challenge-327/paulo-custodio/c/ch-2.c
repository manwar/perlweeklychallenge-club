#include "alloc.h"

int calc_mad(int* nums, int count) {
    if (count < 2)
        return 0;
    int mad = abs(nums[0] - nums[1]);
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count; j++) {
            int dist = abs(nums[i] - nums[j]);
            mad = MIN(mad, dist);
        }
    }
    return mad;
}

void print_mad_pairs(int mad, int* nums, int count) {
    const char* separator = "";
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count; j++) {
            int dist = abs(nums[i] - nums[j]);
            if (dist == mad) {
                printf("%s[%d,%d]", separator, nums[i], nums[j]);
                separator = ", ";
            }
        }
    }
    printf("\n");
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argc--; argv++;
    int* nums = xmalloc(argc * sizeof(int));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);

    qsort(nums, argc, sizeof(int), compare);

    int mad = calc_mad(nums, argc);
    print_mad_pairs(mad, nums, argc);

    xfree(nums);
}
