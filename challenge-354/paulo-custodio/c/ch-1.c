#include "alloc.h"
#include "utarray.h"

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[]) {
    if (argc <= 3)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        utarray_push_back(nums, &num);
    }
    utarray_sort(nums, compare);

    // find minimum difference
    int min = INT_MAX;
    for (size_t i = 0; i < utarray_len(nums) - 1; i++) {
        for (size_t j = i + 1; j < utarray_len(nums); j++) {
            int diff = *(int*)utarray_eltptr(nums, j) -
                       *(int*)utarray_eltptr(nums, i);
            min = MIN(min, diff);
        }
    }

    // print minimum difference
    const char* separator = "";
    for (size_t i = 0; i < utarray_len(nums) - 1; i++) {
        for (size_t j = i + 1; j < utarray_len(nums); j++) {
            int diff = *(int*)utarray_eltptr(nums, j) -
                       *(int*)utarray_eltptr(nums, i);
            if (diff == min) {
                printf("%s[%d, %d]", separator,
                        *(int*)utarray_eltptr(nums, i),
                        *(int*)utarray_eltptr(nums, j));
                separator = ", ";
            }
        }
    }
    printf("\n");

    utarray_free(nums);
}
