#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool double_exists(IntArray* nums) {
    for (int i = 0; i < nums->size-1; i++) {
        for (int j = i+1; j < nums->size; j++) {
            if (nums->data[i] == 2*nums->data[j] ||
                nums->data[j] == 2*nums->data[i])
                return true;
        }
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = double_exists(nums);
    printf("%s\n", bool_to_string(ok));

    intarray_free(nums);
}
