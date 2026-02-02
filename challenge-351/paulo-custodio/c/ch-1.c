#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int special_average(int* nums, size_t size) {
    if (size == 0)
        return 0;

    // get minimum and maximum
    int min = nums[0];
    int max = nums[0];
    for (size_t i = 0; i < size; i++) {
        if (nums[i] < min)
            min = nums[i];
        if (nums[i] > max)
            max = nums[i];
    }

    // compute average
    int count = 0;
    int sum = 0;
    for (size_t i = 0; i < size; i++) {
        if (nums[i] != min && nums[i] != max) {
            count++;
            sum += nums[i];
        }
    }

    if (count == 0)
        return 0;

    return sum / count;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s nums...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argv++; argc--;
    int* nums = malloc(argc * sizeof(int));
    assert(nums != NULL);
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    int average = special_average(nums, argc);
    printf("%d\n", average);
    free(nums);
}
