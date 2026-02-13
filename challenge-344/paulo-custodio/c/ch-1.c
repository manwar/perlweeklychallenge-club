#include "alloc.h"
#include "utarray.h"
#include <ctype.h>

void reverse_list(UT_array* list) {
    int size = utarray_len(list);
    for (int i = 0; i < size/2; i++) {
        int a = *(int*)utarray_eltptr(list, i);
        int b = *(int*)utarray_eltptr(list, size-i-1);
        *(int*)utarray_eltptr(list, i) = b;
        *(int*)utarray_eltptr(list, size-i-1) = a;
    }
}

void add_numbers(UT_array* result, UT_array* a, UT_array* b) {
    int carry = 0;
    for (int i = 0; i < utarray_len(a) || i < utarray_len(b); i++) {
        int a_digit = i < utarray_len(a) ? *(int*)utarray_eltptr(a, i) : 0;
        int b_digit = i < utarray_len(b) ? *(int*)utarray_eltptr(b, i) : 0;
        int sum = carry + a_digit + b_digit;
        int sum_digit = sum % 10;
        carry = sum / 10;
        utarray_push_back(result, &sum_digit);
    }
    if (carry > 0)
        utarray_push_back(result, &carry);
}

void parse_number(UT_array* list, const char* str) {
    utarray_clear(list);
    const char* p = str;
    while (*p != '\0') {
        while (isspace(*p))
            p++;
        if (*p == '\0')
            break;
        if (isdigit(*p)) {
            int digit = *p - '0';
            utarray_push_back(list, &digit);
            p++;
        }
        else
            die("unexpected character: '%c'", *p);
    }
    reverse_list(list);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s list num\n", stderr);

    UT_array *a, *b, *r;
    utarray_new(a, &ut_int_icd);
    utarray_new(b, &ut_int_icd);
    utarray_new(r, &ut_int_icd);

    // get operands
    parse_number(a, argv[1]);
    parse_number(b, argv[2]);

    // add
    add_numbers(r, a, b);

    // print - note reverse order
    const char* separator = "";
    for (int i = utarray_len(r)-1; i >= 0; i--) {
        printf("%s%c", separator, *(int*)utarray_eltptr(r, i) + '0');
        separator = ", ";
    }
    printf("\n");

    utarray_free(a);
    utarray_free(b);
    utarray_free(r);
}
