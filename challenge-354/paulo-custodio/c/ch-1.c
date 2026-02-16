#include "alloc.h"

int main(int argc, char* argv[]) {
    if (argc <= 3)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++) {
        intarray_push_back(nums, atoi(argv[i]));
    }
    intarray_sort(nums);

    // find minimum difference
    int min = INT_MAX;
    for (int i = 0; i < nums->size - 1; i++) {
        for (int j = i + 1; j < nums->size; j++) {
            int diff = nums->data[j] - nums->data[i];
            min = MIN(min, diff);
        }
    }

    // print minimum difference
    const char* separator = "";
    for (int i = 0; i < nums->size - 1; i++) {
        for (int j = i + 1; j < nums->size; j++) {
            int diff = nums->data[j] - nums->data[i];
            if (diff == min) {
                printf("%s[%d, %d]", separator, nums->data[i], nums->data[j]);
                separator = ", ";
            }
        }
    }
    printf("\n");

    intarray_free(nums);
}
