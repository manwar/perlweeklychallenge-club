#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define Epsilon 1e-9

int compare(const void* a, const void* b) {
    if (*(double*)a < *(double*)b) return -1;
    if (*(double*)a > *(double*)b) return 1;
    return 0;
}

bool is_arithmetic_progression(double* nums, size_t size) {
    if (size < 2)
        return false;

    qsort(nums, size, sizeof(double), compare);
    double delta = nums[1] - nums[0];
    for (size_t i = 1; i+1 < size; i++) {
        if (abs((nums[i+1] - nums[i]) - delta) > Epsilon)
            return false;
    }

    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s nums...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argv++; argc--;
    double* nums = malloc(argc * sizeof(double));
    assert(nums != NULL);
    for (int i = 0; i < argc; i++)
        nums[i] = atof(argv[i]);
    bool is_progression = is_arithmetic_progression(nums, argc);
    printf("%s\n", is_progression ? "true" : "false");
    free(nums);
}
