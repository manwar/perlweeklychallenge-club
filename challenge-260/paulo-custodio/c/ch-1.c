#include "alloc.h"

bool unique_occurences(IntArray* nums) {
    intarray_sort(nums);
    IntArray* counts = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        int j = i;
        while (n == nums->data[j])
            j++;
        int count = j - i;
        if (intarray_find_index(counts, count) >= 0) {
            intarray_free(counts);
            return false;
        }
        intarray_push_back(counts, count);
        i = j - 1;
    }

    intarray_free(counts);
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    bool uniq = unique_occurences(nums);
    printf("%d\n", uniq);

    intarray_free(nums);
}
