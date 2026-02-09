#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

void smaller(const int* nums, int* result, int size) {
    for (int i = 0; i < size; i++) {
        int count = 0;
        for (int j = 0; j < size; j++) {
            if (i == j)
                continue;
            if (nums[j] <= nums[i])
                count++;
        }
        result[i] = count;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %0 nums...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argc--; argv++;
    int* nums = malloc(argc * sizeof(int));
    assert(nums);
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);

    int* result = malloc(argc * sizeof(int));
    assert(result);
    smaller(nums, result, argc);

    char* separator = "";
    for (int i = 0; i < argc; i++) {
        printf("%s%d", separator, result[i]);
        separator = ", ";
    }

    free(nums);
    free(result);
}
