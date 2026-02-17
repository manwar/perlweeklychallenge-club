#include "alloc.h"

bool read_row(IntArray* nums) {
    char line[BUFSIZ];
    intarray_clear(nums);
    if (!fgets(line, sizeof(line), stdin))
        return false;
    char* p = strtok(line, " ");
    while (p != NULL) {
        int n = atoi(p);
        intarray_push_back(nums, n);
        p = strtok(NULL, " ");
    }
    return true;
}

int sum_row(IntArray* nums) {
    int sum = 0;
    for (int i = 0; i < nums->size; i++)
        sum += nums->data[i];
    return sum;
}

int max_rows() {
    IntArray* nums = intarray_new();
    int max = 0;
    while (read_row(nums)) {
        int sum = sum_row(nums);
        max = MAX(max, sum);
    }
    intarray_free(nums);
    return max;
}

int main() {
    int max = max_rows();
    printf("%d\n", max);
}
