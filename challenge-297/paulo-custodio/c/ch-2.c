#include "alloc.h"

int num_steps(IntArray* nums) {
    if (nums->size == 0)
        return 0;

    // find min and max
    int min = nums->data[0];
    int max = nums->data[0];
    for (int i = 0; i < nums->size; i++) {
        min = MIN(min, nums->data[i]);
        max = MAX(max, nums->data[i]);
    }

    // travel min down
    int steps = 0;
    while (nums->data[0] != min) {
        int i = intarray_find_index(nums, min);
        int t = nums->data[i]; nums->data[i] = nums->data[i-1]; nums->data[i-1] = t;
        steps++;
    }

    // travel max up
    while (nums->data[nums->size-1] != max) {
        int j = nums->size-1;
        while (j > 0 && nums->data[j] != max)
            j--;
        int t = nums->data[j]; nums->data[j] = nums->data[j+1]; nums->data[j+1] = t;
        steps++;
    }

    return steps;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int steps = num_steps(nums);
    printf("%d\n", steps);

    intarray_free(nums);
}
