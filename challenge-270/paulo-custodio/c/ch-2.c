#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int equalize(IntArray* nums, int x, int y) {
    if (nums->size <= 1)
        return 0;

    intarray_sort(nums);
    int max = nums->data[nums->size-1];

    int cost = 0;
    while (true) {
        // remove items == max
        while (nums->size > 0 && nums->data[nums->size-1] == max)
            intarray_pop_back(nums);
        if (nums->size == 0)
            return cost;

        // apply operations
        if (nums->size == 1) {
            nums->data[0]++;
            cost += x;
        }
        else {
            nums->data[0]++;
            nums->data[1]++;
            cost += y;
        }

        // sort again
        intarray_sort(nums);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 4)
        die("usage: %s x y nums...", argv[0]);

    int x = atoi(argv[1]);
    int y = atoi(argv[2]);
    IntArray* nums = intarray_new();
    for (int i = 3; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int cost = equalize(nums, x, y);
    printf("%d\n", cost);

    intarray_free(nums);
}
