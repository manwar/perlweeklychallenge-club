#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_strong_pair(int a, int b) {
    return abs(a - b) > 0 && abs(a - b) < MIN(a, b);
}

int count_strong_pairs(IntArray* nums) {
    int count = 0;
    intarray_uniq(nums);
    for (int i = 0; i < nums->size - 1; i++) {
        for (int j = i + 1; j < nums->size; j++) {
            if (is_strong_pair(nums->data[i], nums->data[j]))
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_strong_pairs(nums);
    printf("%d\n", count);

    intarray_free(nums);
}
