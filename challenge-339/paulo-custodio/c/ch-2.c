#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int get_peek(int count, int* nums) {
    int altitude = 0;
    int peek = 0;
    for (int i = 0; i < count; i++) {
        altitude += nums[i];
        peek = MAX(peek, altitude);
    }
    return peek;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s nums...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argc--; argv++;
    int* nums = malloc(argc * sizeof(int));
    assert(nums);
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    int peek = get_peek(argc, nums);
    printf("%d\n", peek);
    free(nums);
}
