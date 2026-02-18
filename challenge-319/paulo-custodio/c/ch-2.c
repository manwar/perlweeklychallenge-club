#include "alloc.h"

IntArray* parse_int_list() {
    char line[BUFSIZ];
    IntArray* nums = intarray_new();

    if (!fgets(line, sizeof(line), stdin))
        die("missing data");

    char* p = line;
    const char* separators = " \t,";
    p = strtok(line, separators);
    while (p != NULL) {
        intarray_push_back(nums, atoi(p));
        p = strtok(NULL, separators);
    }

    return nums;
}

int min_common(IntArray* nums1, IntArray* nums2) {
    intarray_sort(nums1);
    for (int i = 0; i < nums1->size; i++) {
        int found = intarray_find_index(nums2, nums1->data[i]);
        if (found >= 0)
            return nums1->data[i];
    }
    return -1;
}

int main() {
    IntArray* nums1 = parse_int_list();
    IntArray* nums2 = parse_int_list();
    int common = min_common(nums1, nums2);
    printf("%d\n", common);
    intarray_free(nums1);
    intarray_free(nums2);
}
