#include "alloc.h"

int product_sign(IntArray* nums) {
    int sign = 1;
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (n == 0)
            return 0;
        else if (n < 0)
            n = -1;
        else
            n = 1;

        sign *= n;
    }
    return sign;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sign = product_sign(nums);
    printf("%d\n", sign);

    intarray_free(nums);
}
