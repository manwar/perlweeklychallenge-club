#include "alloc.h"
#include "utarray.h"

void kolakoski(int n, UT_array* seq, UT_array* count) {
    // init sequence
    int num;
    num = 1; utarray_push_back(seq, &num);
    num = 2; utarray_push_back(seq, &num);
    num = 2; utarray_push_back(seq, &num);

    // init count
    num = 1; utarray_push_back(count, &num);
    num = 2; utarray_push_back(count, &num);

    // compute sequence
    for (int i = 3; i <= n; i++) {
        int cnt = *(int*)utarray_eltptr(seq, i-1);
        int num = 3 - *(int*)utarray_eltptr(seq, utarray_len(seq) - 1);
        for (int j = 0; j < cnt; j++) {
            utarray_push_back(seq, &num);
        }
        utarray_push_back(count, &cnt);
    }
}

int count_ones(UT_array* nums) {
    int count = 0;
    for (size_t i = 0; i < utarray_len(nums); i++) {
        if (*(int*)utarray_eltptr(nums, i) == 1)
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("Usage: %s num", argv[0]);

    int n = atoi(argv[1]);

    UT_array* seq;
    utarray_new(seq, &ut_int_icd);
    UT_array* count;
    utarray_new(count, &ut_int_icd);

    kolakoski(n, seq, count);
    int ones = count_ones(count);
    printf("%d\n", ones);

    utarray_free(seq);
    utarray_free(count);
}
