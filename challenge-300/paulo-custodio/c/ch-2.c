#include "alloc.h"

int max_len_nested(IntArray* nums) {
    int max_len = 0;
    for (int i = 0; i < nums->size; i++) {
        IntArray* seq = intarray_new();
        int idx = i;
        while (true) {
            int next = nums->data[idx];
            if (intarray_find_index(seq, next) >= 0)
                break; // already found
            intarray_push_back(seq, next);
            idx = next;
        }
        max_len = MAX(max_len, seq->size);
        intarray_free(seq);
    }
    return max_len;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int len = max_len_nested(nums);
    printf("%d\n", len);

    intarray_free(nums);
}
