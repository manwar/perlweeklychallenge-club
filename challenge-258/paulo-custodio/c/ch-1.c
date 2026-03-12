#include "alloc.h"

int count_even_digits(IntArray* nums) {
    char buffer[32];
    int count = 0;
    for (int i = 0; i < nums->size; i++) {
        sprintf(buffer, "%d", nums->data[i]);
        if (strlen(buffer) % 2 == 0)
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_even_digits(nums);
    printf("%d\n", count);

    intarray_free(nums);
}
