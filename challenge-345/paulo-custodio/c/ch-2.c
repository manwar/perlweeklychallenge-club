#include "alloc.h"
#include "utarray.h"

void utarray_push_front(UT_array* ints, int* n) {
    // make space
    int zero = 0;
    utarray_push_back(ints, &zero);

    // move data
    memmove(utarray_eltptr(ints, 1), utarray_eltptr(ints, 0),
            (utarray_len(ints) - 1) * sizeof(int));

    // insert data
    *(int*)utarray_eltptr(ints, 0) = *n;
}

void last_visitor(UT_array* nums, UT_array* ans) {
    UT_array* seen;
    utarray_new(seen, &ut_int_icd);

    int x = 0;  // how many -1s in a row BEFORE this one
    for (int i = 0; i < utarray_len(nums); i++) {
        int n = *(int*)utarray_eltptr(nums, i);
        if (n >= 0) {
            utarray_push_front(seen, &n);
            x = 0;  // reset streak
        }
        else {
            // use current x
            int n = (x < utarray_len(seen)) ?
                    *(int*)utarray_eltptr(seen, x) : -1;
            utarray_push_back(ans, &n);
            x++;    // increment streak for next -1
        }
    }

    utarray_free(seen);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argv++; argc--;
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        utarray_push_back(nums, &num);
    }

    UT_array* ans;
    utarray_new(ans, &ut_int_icd);

    last_visitor(nums, ans);

    const char* separator = "";
    for (int i = 0; i < utarray_len(ans); i++) {
        printf("%s%d", separator, *(int*)utarray_eltptr(ans, i));
        separator = ", ";
    }

    utarray_free(nums);
    utarray_free(ans);
}
