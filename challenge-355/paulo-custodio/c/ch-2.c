#include "alloc.h"

bool check_mountain(IntArray* nums) {
    if (nums->size < 3)
        return false;
    if (nums->data[0] >= nums->data[1])
        return false;
    bool climbing = true;
    for (int i = 1; i < nums->size; i++) {
        if (nums->data[i] == nums->data[i-1]) {         // flat
            return false;
        }
        else if (nums->data[i] > nums->data[i-1]) {     // climbing
            if (!climbing)
                return false;
        }
        else {                                          // descending
            if (climbing)
                climbing = false;
        }
    }
    return !climbing;
}

int main(int argc, char*argv[]) {
    if (argc < 2)
        die("Usage: %s numbers...", argv[0]);

    argc--; argv++;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++) {
        intarray_push_back(nums, atoi(argv[i]));
    }
    bool is_mountain = check_mountain(nums);
    printf("%s\n", bool_to_string(is_mountain));
    intarray_free(nums);
}
