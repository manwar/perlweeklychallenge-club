#include "alloc.h"
#include "utarray.h"

bool check_mountain(UT_array* nums) {
    if (utarray_len(nums) < 3)
        return false;
    if (*(int*)utarray_eltptr(nums, 0) >= *(int*)utarray_eltptr(nums, 1))
        return false;
    bool climbing = true;
    for (size_t i = 1; i < utarray_len(nums); i++) {
        if (*(int*)utarray_eltptr(nums, i) == *(int*)utarray_eltptr(nums, i-1)) {         // flat
            return false;
        }
        else if (*(int*)utarray_eltptr(nums, i) > *(int*)utarray_eltptr(nums, i-1)) {     // climbing
            if (!climbing)
                return false;
        }
        else {                              // descending
            if (climbing)
                climbing = false;
        }
    }
    return !climbing;
}

int main(int argc, char*argv[]) {
    if (argc < 2)
        die("Usage: %s numbers...", argv[0]);

    argc--; argv++;
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        utarray_push_back(nums, &num);
    }
    bool is_mountain = check_mountain(nums);
    printf("%s\n", is_mountain ? "true" : "false");
    utarray_free(nums);
}
