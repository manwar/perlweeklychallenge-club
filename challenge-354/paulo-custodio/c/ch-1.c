#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MIN(a,b) ((a)<(b)?(a):(b))

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[]) {
    if (argc <= 3) {
        fprintf(stderr, "usage: %s nums...\n", argv[0]);
        return EXIT_FAILURE;
    }

    // read numbers
    size_t nums_count = argc - 1;
    int* nums = malloc(nums_count * sizeof(int));
    assert(nums);

    for (int i = 0; i < nums_count; i++) {
        nums[i] = atoi(argv[i + 1]);
    }

    // sort
    qsort(nums, nums_count, sizeof(int), compare);

    // find minimum difference
    int min = INT_MAX;
    for (int i = 0; i < nums_count - 1; i++) {
        for (int j = i + 1; j < nums_count; j++) {
            int diff = nums[j] - nums[i];
            min = MIN(min, diff);
        }
    }

    // print minimum difference
    const char* separator = "";
    for (int i = 0; i < nums_count - 1; i++) {
        for (int j = i + 1; j < nums_count; j++) {
            int diff = nums[j] - nums[i];
            if (diff == min) {
                printf("%s[%d, %d]", separator, nums[i], nums[j]);
                separator = ", ";
            }
        }
    }
    printf("\n");

    free(nums);
}
