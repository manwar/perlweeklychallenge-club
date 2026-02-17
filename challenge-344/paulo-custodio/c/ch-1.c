#include "alloc.h"
#include <ctype.h>

void add_numbers(IntArray* result, IntArray* a, IntArray* b) {
    int carry = 0;
    for (int i = 0; i < a->size || i < b->size; i++) {
        int a_digit = i < a->size ? a->data[i] : 0;
        int b_digit = i < b->size ? b->data[i] : 0;
        int sum = carry + a_digit + b_digit;
        int sum_digit = sum % 10;
        carry = sum / 10;
        intarray_push_back(result, sum_digit);
    }
    if (carry > 0)
        intarray_push_back(result, carry);
}

void parse_number(IntArray* list, const char* str) {
    intarray_clear(list);
    const char* p = str;
    while (*p != '\0') {
        if (isspace(*p)) {
            p++;
            continue;
        }
        if (isdigit(*p)) {
            int digit = *p - '0';
            intarray_push_back(list, digit);
            p++;
        }
        else
            die("unexpected character: '%c'", *p);
    }
    intarray_reverse(list);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s list num\n", stderr);

    IntArray* a = intarray_new();
    IntArray* b = intarray_new();
    IntArray* r = intarray_new();

    // get operands
    parse_number(a, argv[1]);
    parse_number(b, argv[2]);

    // add
    add_numbers(r, a, b);

    // print - note reverse order
    const char* separator = "";
    for (int i = r->size - 1; i >= 0; i--) {
        printf("%s%c", separator, r->data[i] + '0');
        separator = ", ";
    }
    printf("\n");

    intarray_free(a);
    intarray_free(b);
    intarray_free(r);
}
