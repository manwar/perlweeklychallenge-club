#include "alloc.h"

int largest_number(const char* prefix, IntArray* nums) {
    int cur_num = atoi(prefix);
    if (nums->size == 0) {
        return cur_num;
    }

    int max_num = 0;
    for (int i = 0; i < nums->size; i++) {
        Str* new_prefix = str_new();
        str_printf(new_prefix, "%s%d", prefix, nums->data[i]);

        IntArray* new_nums = intarray_new();
        for (int j = 0; j < nums->size; j++) {
            if (j != i)
                intarray_push_back(new_nums, nums->data[j]);
        }

        // recurse
        int new_num = largest_number(new_prefix->body, new_nums);
        max_num = MAX(max_num, new_num);

        str_free(new_prefix);
        intarray_free(new_nums);
    }

    return max_num;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int max = largest_number("", nums);
    printf("%d\n", max);

    intarray_free(nums);
}
