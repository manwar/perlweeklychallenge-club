#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* get_list_sum_zero(int num) {
    IntArray* nums = intarray_new();
    for (int i = 1; i <= num/2; i++) {
        intarray_push_back(nums, i);
        intarray_push_back(nums, -i);
    }
    if (num % 2 != 0)
        intarray_push_back(nums, 0);
    intarray_sort(nums);
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s num", argv[0]);

    int num = atoi(argv[1]);
    IntArray* nums = get_list_sum_zero(num);
    intarray_print(nums);
    intarray_free(nums);
}
