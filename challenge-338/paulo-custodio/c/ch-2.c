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

int max_distance() {
    int* a = NULL;
    int a_count = 0;
    int* b = NULL;
    int b_count = 0;

    a = read_row(&a_count);
    if (a == NULL) {
        fprintf(stderr, "missing input data\n");
        exit(EXIT_FAILURE);
    }

    b = read_row(&b_count);
    if (b == NULL) {
        fprintf(stderr, "missing input data\n");
        exit(EXIT_FAILURE);
    }

    int max_dist = 0;
    for (int i = 0; i < a_count; i++) {
        for (int j = 0; j < b_count; j++) {
            int dist = abs(a[i] - b[j]);
            max_dist = MAX(max_dist, dist);
        }
    }
    return max_dist;
}

int main() {
    int max_dist = max_distance();
    printf("%d\n", max_dist);
}
