#include "alloc.h"

int get_max_seq_len(IntArray* nums) {
    int max_len = -1;
    intarray_sort(nums);
    for (int i = 0; i < nums->size; i++) {
        int j = i+1;
        while (j < nums->size && nums->data[j] == nums->data[j-1] + 1)
            j++;
        int len = j - i;
        if (len > 1)
            max_len = MAX(max_len, len);
        i = j-1;
    }
    return max_len;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int seq_len = get_max_seq_len(nums);
    printf("%d\n", seq_len);

    intarray_free(nums);
}
