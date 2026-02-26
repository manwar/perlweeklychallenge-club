#include "alloc.h"

IntArray* parse_list() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");
    return intarray_parse_list(line);
}

int parse_num() {
    IntArray* nums = parse_list();
    if (nums->size != 1)
        die("invalid data");
    int n = nums->data[0];
    intarray_free(nums);
    return n;
}

int max_sum(IntArray* nums, int n) {
    int max = INT_MIN;
    for (int i = 0; i+n <= nums->size; i++) {
        int sum = 0;
        for (int j = i; j < i+n; j++) {
            sum += nums->data[j];
        }
        max = MAX(max, sum);
    }
    return max;
}

int main() {
    IntArray* nums = parse_list();
    int n = parse_num();
    int sum = max_sum(nums, n);
    printf("%.2f\n", (double)sum / n);
    intarray_free(nums);
}
