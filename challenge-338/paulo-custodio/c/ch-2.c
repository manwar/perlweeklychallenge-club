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

int max_distance() {
    IntArray* a = intarray_new();
    IntArray* b = intarray_new();

    if (!read_row(a))
        die("missing input data");

    if (!read_row(b))
        die("missing input data");

    int max_dist = 0;
    for (int i = 0; i < a->size; i++) {
        for (int j = 0; j < b->size; j++) {
            int dist = abs(a->data[i] - b->data[j]);
            max_dist = MAX(max_dist, dist);
        }
    }

    intarray_free(a);
    intarray_free(b);
    return max_dist;
}

int main() {
    int max_dist = max_distance();
    printf("%d\n", max_dist);
}
