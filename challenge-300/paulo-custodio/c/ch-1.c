#include "alloc.h"

bool is_beautiful(IntArray* nums) {
    for (int i = 1; i <= nums->size; i++) {
        int item = nums->data[i-1];
        if (item % i != 0 && i % item != 0)
            return false;
    }
    return true;
}

void permute(IntArray* prefix, IntArray* pending, int* num_beautiful) {
    if (pending->size == 0) {
        if (is_beautiful(prefix))
            (*num_beautiful)++;
        return;
    }

    for (int i = 0; i < pending->size; i++) {
        intarray_push_back(prefix, pending->data[i]);

        IntArray* new_pending = intarray_new();
        for (int j = 0; j < pending->size; j++) {
            if (j != i)
                intarray_push_back(new_pending, pending->data[j]);
        }

        permute(prefix, new_pending, num_beautiful);

        intarray_pop_back(prefix);
        intarray_free(new_pending);
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    IntArray* nums = intarray_new();
    for (int i = 1; i <= n; i++)
        intarray_push_back(nums, i);

    IntArray* prefix = intarray_new();
    int num_beautiful = 0;

    permute(prefix, nums, &num_beautiful);

    printf("%d\n", num_beautiful);

    intarray_free(nums);
    intarray_free(prefix);
}
