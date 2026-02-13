#include "alloc.h"
#include "utarray.h"

bool read_row(UT_array* nums) {
    char line[BUFSIZ];
    utarray_clear(nums);
    if (!fgets(line, sizeof(line), stdin))
        return false;
    char* p = strtok(line, " ");
    while (p != NULL) {
        int n = atoi(p);
        utarray_push_back(nums, &n);
        p = strtok(NULL, " ");
    }
    return true;
}

int sum_row(UT_array* nums) {
    int sum = 0;
    for (int i = 0; i < utarray_len(nums); i++)
        sum += *(int*)utarray_eltptr(nums, i);
    return sum;
}

int max_rows() {
    UT_array* nums;
    utarray_new(nums, &ut_int_icd);
    int max = 0;
    while (read_row(nums)) {
        int sum = sum_row(nums);
        max = MAX(max, sum);
    }
    utarray_free(nums);
    return max;
}

int main() {
    int max = max_rows();
    printf("%d\n", max);
}
