#include "alloc.h"

void find_max_points_1(int points, IntArray* nums, int* max) {
    if (nums->size == 0) {
        *max = MAX(*max, points);
        return;
    }

    for (int i = 0; i < nums->size; i++) {
        int selected = nums->data[i];
        IntArray* copy = intarray_new();
        for (int j = 0; j < nums->size; j++) {
            if (j != i && nums->data[j] != selected-1 && nums->data[j] != selected+1)
                intarray_push_back(copy, nums->data[j]);
        }
        find_max_points_1(points+selected, copy, max);
        intarray_free(copy);
    }
}

int find_max_points(IntArray* nums) {
    int max = 0;
    find_max_points_1(0, nums, &max);
    return max;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));
    int points = find_max_points(nums);
    printf("%d\n", points);
    intarray_free(nums);
}
