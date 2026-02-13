#include "alloc.h"
#include "utarray.h"

UT_array* find_peeks(UT_array* nums) {
    UT_array* peeks;
    utarray_new(peeks, &ut_int_icd);

    for (int i = 1; i < utarray_len(nums)-1; i++) {
        int peek = *(int*)utarray_eltptr(nums, i);
        if (peek > *(int*)utarray_eltptr(nums, i - 1) &&
            peek > *(int*)utarray_eltptr(nums, i + 1)) {
            // found peek
            utarray_push_back(peeks, &i);
        }
    }
    return peeks;
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
    UT_array* peeks = find_peeks(nums);

    if (utarray_len(peeks) == 0) {
        printf("0\n");
    }
    else {
        const char* separator = "";
        for (int i = 0; i < utarray_len(peeks); i++) {
            printf("%s%d", separator, *(int*)utarray_eltptr(peeks, i));
            separator = ", ";
        }
    }

    utarray_free(peeks);
    utarray_free(nums);
}
