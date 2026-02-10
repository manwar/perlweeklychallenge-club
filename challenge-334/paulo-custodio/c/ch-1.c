#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* read_nums(int* count) {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        return NULL;

    int* nums = NULL;
    *count = 0;
    char* p = strtok(line, " ");
    while (p != NULL) {
        int n = atoi(p);
        (*count)++;
        nums = realloc(nums, (*count) * sizeof(int));
        assert(nums);
        nums[(*count)-1] = n;

        p = strtok(NULL, " ");
    }

    return nums;
}

int sum_range() {
    int nums_count = 0;
    int* nums = read_nums(&nums_count);
    if (nums == NULL)
        return 0;

    int range_count = 0;
    int* range = read_nums(&range_count);
    if (range == NULL || range_count != 2) {
        free(nums);
        return 0;
    }

    int sum = 0;
    for (int i = range[0]; i <= range[1]; i++)
        sum += nums[i];

    free(nums);
    free(range);

    return sum;
}

int main() {
    int sum = sum_range();
    printf("%d\n", sum);
}
