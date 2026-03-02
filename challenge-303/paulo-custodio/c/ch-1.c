#include "alloc.h"

void find_nums_1(IntArray* out, int prefix, const char* digits) {
    if (prefix >= 100 && prefix < 1000 && prefix % 2 == 0) {
        int found = intarray_find_index(out, prefix);
        if (found < 0)
            intarray_push_back(out, prefix);
        return;
    }

    if (prefix >= 1000)
        return;

    for (int i = 0; digits[i] != '\0'; i++) {
        int digit = digits[i] - '0';
        char* new_digits = xstrdup(digits);
        memmove(new_digits+i, new_digits+i+1, strlen(new_digits+i+1)+1);
        int new_prefix = 10*prefix+digit;
        find_nums_1(out, new_prefix, new_digits);
        xfree(new_digits);
    }
}

IntArray* find_nums(const char* digits) {
    IntArray* out = intarray_new();
    find_nums_1(out, 0, digits);
    intarray_sort(out);
    return out;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s digits...", argv[0]);

    Str* digits = str_new();
    for (int i = 1; i < argc; i++)
        str_append(digits, argv[i]);

    IntArray* nums = find_nums(digits->body);
    intarray_print(nums);

    str_free(digits);
    intarray_free(nums);
}
