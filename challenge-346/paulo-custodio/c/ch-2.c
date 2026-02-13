#include "alloc.h"
#include "utarray.h"
#include <ctype.h>

UT_array* output;

void skip_spaces(const char** pp) {
    while (isspace(**pp)) {
        (*pp)++;
    }
}

int eval_sum(const char** pp);

int eval_term(const char** pp) {
    skip_spaces(pp);

    if (**pp == '\0' || (!isdigit(**pp) && **pp != '('))
        die("expected number or '(' but found '%c'", **pp);

    int value = 0;

    if (**pp == '(') {
        (*pp)++; // skip '('
        value = eval_sum(pp); // recurse
        skip_spaces(pp);
        if (**pp == ')') {
            (*pp)++; // skip ')'
        }
    } else {
        while (isdigit(**pp)) {
            value = value * 10 + (**pp - '0');
            (*pp)++;
        }
    }
    skip_spaces(pp);
    return value;
}

int eval_product(const char** pp) {
    skip_spaces(pp);
    int a = eval_term(pp);
    skip_spaces(pp);

    while (**pp == '*' || **pp == '/') {
        char op = **pp;
        (*pp)++;
        int b = eval_term(pp);
        if (op == '*') a *= b;
        else if (b != 0) a /= b;
        else die("division by zero");
        skip_spaces(pp);
    }
    return a;
}

int eval_sum(const char** pp) {
    skip_spaces(pp);
    int a = eval_product(pp);
    skip_spaces(pp);

    while (**pp == '+' || **pp == '-') {
        char op = **pp;
        (*pp)++;
        int b = eval_product(pp);
        if (op == '+') a += b;
        else a -= b;
        skip_spaces(pp);
    }
    return a;
}

int eval_expr(const char* str) {
    const char* p = str;
    int result = eval_sum(&p);
    skip_spaces(&p);
    if (*p != '\0')
        die("invalid expression: %s", str);
    return result;
}

void find_exprs(const char* expr, const char* digits, int target) {
    if (digits[0] == '\0') {    // no more attempts
        int n = eval_expr(expr);
        if (n == target)
            utarray_push_back(output, &expr);
        return;
    }

    // try all prefixes and operators
    int digits_len = strlen(digits);
    for (int len = 1; len <= digits_len; len++) {

        if (digits[0] == '0' && len > 1) {
            break; // skip leading zeros
        }

        char* new_expr = xmalloc(strlen(expr) + 1 + len + 1);

        if (expr[0] == '\0') {
            sprintf(new_expr, "%.*s", len, digits);
            find_exprs(new_expr, digits+len, target);
        }
        else {
            char* ops = "+-*";
            for (char* op = ops; *op != '\0'; op++) {
                sprintf(new_expr, "%s%c%.*s", expr, *op, len, digits);
                find_exprs(new_expr, digits+len, target);
            }
        }

        xfree(new_expr);
    }
}

void find_all_exprs(const char* digits, int target) {
    find_exprs("", digits, target);
}

int compare(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s digits target\n", argv[0]);

    utarray_new(output, &ut_str_icd);

    find_all_exprs(argv[1], atoi(argv[2]));
    utarray_sort(output, compare);
    const char* separator = "";
    for (size_t i = 0; i < utarray_len(output); i++) {
        printf("%s%s", separator, *(char**)utarray_eltptr(output, i));
        separator = ", ";
    }
    printf("\n");

    utarray_free(output);
}
