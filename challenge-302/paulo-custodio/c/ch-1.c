#include "alloc.h"

StrArray* parse_strings() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");
    StrArray* list = strarray_parse_list(line);
    return list;
}

void parse_x_y(int* x, int* y) {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");
    IntArray* nums = intarray_parse_list(line);
    if (nums->size != 2)
        die("insufficient data");
    *x = nums->data[0];
    *y = nums->data[1];
    intarray_free(nums);
}

int count_char(const char* str, char c) {
    int count = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == c)
            count++;
    }
    return count;
}

int count_char_subset(StrArray* strs, char c) {
    int count = 0;
    for (int i = 0; i < strs->size; i++) {
        count += count_char(strs->data[i], c);
    }
    return count;
}

void find_largest_subset(StrArray* prefix, StrArray* strs, int x, int y, int* max_subset) {
    // check current subset
    int count_0 = count_char_subset(prefix, '0');
    int count_1 = count_char_subset(prefix, '1');

    if (count_0 > x || count_1 > y)
        return;     // trim the search

    if (count_0 <= x && count_1 <= y) {
        *max_subset = MAX(*max_subset, prefix->size);
    }

    for (int i = 0; i < strs->size; i++) {
        // copy prefix, append this item
        StrArray* new_prefix = strarray_new();
        for (int j = 0; j < prefix->size; j++)
            strarray_push_back(new_prefix, prefix->data[j]);
        strarray_push_back(new_prefix, strs->data[i]);

        // copy strs, remove this item
        StrArray* new_strs = strarray_new();
        for (int j = 0; j < strs->size; j++) {
            if (j != i)
                strarray_push_back(new_strs, strs->data[j]);
        }

        // recurse
        find_largest_subset(new_prefix, new_strs, x, y, max_subset);

        // free data
        strarray_free(new_prefix);
        strarray_free(new_strs);
    }
}

int main() {
    int max_subset = 0;
    int x, y;
    StrArray* prefix = strarray_new();
    StrArray* strs = parse_strings();
    parse_x_y(&x, &y);
    find_largest_subset(prefix, strs, x, y, &max_subset);
    printf("%d\n", max_subset);
    strarray_free(prefix);
    strarray_free(strs);
}
