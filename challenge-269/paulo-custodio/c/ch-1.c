#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool trailing_zero(IntArray* nums) {
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        if ((nums->data[i] & 1) == 0)
            count++;
    }
    return count >= 2;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool ok = trailing_zero(nums);
    printf("%s\n", bool_to_string(ok));

    intarray_free(nums);
}
