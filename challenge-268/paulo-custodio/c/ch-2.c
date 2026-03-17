#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* number_game(IntArray* nums) {
    IntArray* output = intarray_new();
    intarray_sort(nums);
    for (int i = 0; i+1 < nums->size; i += 2) {
        intarray_push_back(output, nums->data[i+1]);
        intarray_push_back(output, nums->data[i]);
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* result = number_game(nums);
    intarray_print(result);

    intarray_free(nums);
    intarray_free(result);
}
