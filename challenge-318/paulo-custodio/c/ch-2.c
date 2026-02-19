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

bool reverse_equal(IntArray* n1, IntArray* n2) {
    // both empty
    if (n1->size == 0 && n2->size == 0)
        return true;

    // different sizes
    if (n1->size != n2->size)
        return false;

    // already equal
    if (memcmp(n1->data, n2->data, n1->size * sizeof(int)) == 0)
        return true;

    // test reversal of subgroups
    IntArray* temp = intarray_new();
    intarray_resize(temp, n1->size);
    for (int i = 0; i < n1->size - 1; i++) {
        for (int len = 1; i + len < n1->size; len++) {
            // copy n2
            memcpy(temp->data, n2->data, n1->size * sizeof(int));

            // reverse subset of temp
            int b = i, t = i + len - 1;
            while (b < t) {
                int x = temp->data[t];
                temp->data[t] = temp->data[b];
                temp->data[b] = x;
                b++; t--;
            }

            // check if equal
            if (memcmp(n1->data, temp->data, n1->size * sizeof(int)) == 0) {
                intarray_free(temp);
                return true;
            }
        }
    }

    intarray_free(temp);
    return false;
}

int main() {
    IntArray* n1 = parse_int_list();
    IntArray* n2 = parse_int_list();
    bool equal = reverse_equal(n1, n2);
    printf("%s\n", bool_to_string(equal));
    intarray_free(n1);
    intarray_free(n2);
}
