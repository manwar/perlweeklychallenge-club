#include "alloc.h"

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
    if (argc < 2)
        die("usage: %0 nums...", argv[0]);

    argc--; argv++;
    int* nums = xmalloc(argc * sizeof(int));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);

    int* result = xmalloc(argc * sizeof(int));
    smaller(nums, result, argc);

    char* separator = "";
    for (int i = 0; i < argc; i++) {
        printf("%s%d", separator, result[i]);
        separator = ", ";
    }

    xfree(nums);
    xfree(result);
}
