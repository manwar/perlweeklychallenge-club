#include "alloc.h"

IntArray* read_nums() {
    IntArray* nums = intarray_new();

    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        return nums;

    char* p = strtok(line, " ");
    while (p != NULL) {
        intarray_push_back(nums, atoi(p));
        p = strtok(NULL, " ");
    }

    return nums;
}

int sum_range() {
    IntArray* nums = read_nums();
    if (nums->size == 0) {
        intarray_free(nums);
        return 0;
    }

    IntArray* range = read_nums();
    if (range->size != 2) {
        intarray_free(nums);
        intarray_free(range);
        return 0;
    }

    int sum = 0;
    for (int i = range->data[0]; i <= range->data[1] && i < nums->size; i++)
        sum += nums->data[i];

    intarray_free(nums);
    intarray_free(range);
    return sum;
}

int main() {
    int sum = sum_range();
    printf("%d\n", sum);
}
