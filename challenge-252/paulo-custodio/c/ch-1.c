#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_special(IntArray* nums, int index) {    // index is one-based
    if (index < 1 || index > nums->size)
        return false;
    if (nums->size % index == 0)
        return true;
    else
        return false;
}

int sum_squares_special(IntArray* nums) {
    int sum = 0;
    for (int index = 1; index <= nums->size; index++) {
        if (is_special(nums, index))
            sum += nums->data[index-1] * nums->data[index-1];   // index 1-based
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = sum_squares_special(nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
