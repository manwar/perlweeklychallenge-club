#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int* read_row(int* count) {
    char line[BUFSIZ];
    int* nums = NULL;
    *count = 0;
    if (!fgets(line, sizeof(line), stdin))
        return NULL;
    char* p = strtok(line, " ");
    while (p != NULL) {
        int n = atoi(p);
        (*count)++;
        nums = realloc(nums, *count * sizeof(int));
        assert(nums);
        nums[*count-1] = n;
        p = strtok(NULL, " ");
    }
    return nums;
}

int sum_row(int* nums, int count) {
    int sum = 0;
    for (int i = 0; i < count; i++)
        sum += nums[i];
    return sum;
}

int max_rows() {
    int* nums = NULL;
    int count = 0;
    int max = 0;
    while ((nums = read_row(&count)) != NULL) {
        int sum = sum_row(nums, count);
        max = MAX(max, sum);
        free(nums);
    }
    return max;
}

int main() {
    int max = max_rows();
    printf("%d\n", max);
}
