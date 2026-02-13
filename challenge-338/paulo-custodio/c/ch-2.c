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

int max_distance() {
    UT_array* a;
    utarray_new(a, &ut_int_icd);
    UT_array* b;
    utarray_new(b, &ut_int_icd);

    if (!read_row(a))
        die("missing input data");

    if (!read_row(b))
        die("missing input data");

    int max_dist = 0;
    for (int i = 0; i < utarray_len(a); i++) {
        for (int j = 0; j < utarray_len(b); j++) {
            int dist = abs(*(int*)utarray_eltptr(a, i) -
                           *(int*)utarray_eltptr(b, j));
            max_dist = MAX(max_dist, dist);
        }
    }

    utarray_free(a);
    utarray_free(b);

    return max_dist;
}

int main() {
    int max_dist = max_distance();
    printf("%d\n", max_dist);
}
