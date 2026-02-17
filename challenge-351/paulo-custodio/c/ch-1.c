#include "alloc.h"

int special_average(IntArray* nums) {
    if (nums->size == 0)
        return 0;

    // get minimum and maximum
    int min = nums->data[0];
    int max = nums->data[0];
    for (int i = 0; i < nums->size; i++) {
        min = MIN(min, nums->data[i]);
        max = MAX(max, nums->data[i]);
    }

    // compute average
    int count = 0;
    int sum = 0;
    for (int i = 0; i < nums->size; i++) {
        int num = nums->data[i];
        if (num != min && num != max) {
            count++;
            sum += num;
        }
    }

    if (count == 0)
        return 0;

    return sum / count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argv++; argc--;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++) {
        intarray_push_back(nums, atoi(argv[i]));
    }
    int average = special_average(nums);

    printf("%d\n", average);
    intarray_free(nums);
}
