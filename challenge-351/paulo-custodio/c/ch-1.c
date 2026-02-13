#include "alloc.h"
#include "utarray.h"

int special_average(UT_array* nums) {
    if (utarray_len(nums) == 0)
        return 0;

    // get minimum and maximum
    int min = *(int*)utarray_eltptr(nums, 0);
    int max = *(int*)utarray_eltptr(nums, 0);
    for (size_t i = 0; i < utarray_len(nums); i++) {
        min = MIN(min, *(int*)utarray_eltptr(nums, i));
        max = MAX(max, *(int*)utarray_eltptr(nums, i));
    }

    // compute average
    int count = 0;
    int sum = 0;
    for (size_t i = 0; i < utarray_len(nums); i++) {
        int num = *(int*)utarray_eltptr(nums, i);
        if (num != min && num != max) {
            count++;
            sum += num;
        }
    }

    if (count == 0)
        return 0;

    return sum / count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argv++; argc--;
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        utarray_push_back(nums, &num);
    }
    int average = special_average(nums);

    printf("%d\n", average);
    utarray_free(nums);
}
