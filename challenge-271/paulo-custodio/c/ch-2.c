#include "alloc.h"

typedef struct {
    int num;
    int num_1_bits;
} Num;

int count_1_bits(int n) {
    int count = 0;
    while (n > 0) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int compare(const void* a_, const void* b_) {
    Num* a = (Num*)a_;
    Num* b = (Num*)b_;
    if (a->num_1_bits != b->num_1_bits)
        return a->num_1_bits - b->num_1_bits;
    else
        return a->num - b->num;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    Num* nums_bits = xmalloc(nums->size * sizeof(Num));
    for (int i = 0; i < nums->size; i++) {
        nums_bits[i].num = nums->data[i];
        nums_bits[i].num_1_bits = count_1_bits(nums->data[i]);
    }

    qsort(nums_bits, nums->size, sizeof(Num), compare);

    printf("(");
    for (int i = 0; i < nums->size; i++) {
        if (i > 0)
            printf(", ");
        printf("%d", nums_bits[i].num);
    }
    printf(")\n");

    intarray_free(nums);
    xfree(nums_bits);
}
