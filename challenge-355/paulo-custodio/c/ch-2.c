#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool check_mountain(int* nums, size_t size) {
    if (size < 3)
        return false;
    if (nums[0] >= nums[1])
        return false;
    bool climbing = true;
    for (size_t i = 1; i < size; i++) {
        if (nums[i] == nums[i-1]) {         // flat
            return false;
        }
        else if (nums[i] > nums[i-1]) {     // climbing
            if (!climbing)
                return false;
        }
        else {                              // descending
            if (climbing)
                climbing = false;
        }
    }
    return !climbing;
}

int main(int argc, char*argv[]) {
    if (argc < 2) {
        fputs("Usage: ch-1 numbers...\n", stderr);
        exit(EXIT_FAILURE);
    }

    // alloc array
    size_t size = argc - 1;
    int* nums = malloc(size * sizeof(int));
    assert(nums);

    // fill array
    for (size_t i = 0; i < size; i++) {
        nums[i] = atoi(argv[i+1]);
    }

    // check if it is a mountain
    bool is_mountain = check_mountain(nums, size);

    // free memory
    free(nums);

    // output
    printf("%s\n", is_mountain ? "true" : "false");
}
