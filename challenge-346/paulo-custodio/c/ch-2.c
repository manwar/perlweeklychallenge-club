#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** output = NULL;
size_t output_size = 0;

void add_output(const char* str) {
    output_size++;
    output = realloc(output, output_size * sizeof(char*));
    assert(output != NULL);
    output[output_size-1] = strdup(str);
    assert(output[output_size-1] != NULL);
}

int compare(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

void sort_output() {
    qsort(output, output_size, sizeof(char*), compare);
}

void skip_spaces(const char** pp) {
    while (isspace(**pp)) {
        (*pp)++;
    }
}

int eval_sum(const char** pp);

int eval_term(const char** pp) {
    skip_spaces(pp);

    if (**pp == '\0' || (!isdigit(**pp) && **pp != '(')) {
        fprintf(stderr, "expected number or '(' but found '%c'\n", **pp);
        exit(EXIT_FAILURE);
    }

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
        else {
            fprintf(stderr, "division by zero\n");
            exit(EXIT_FAILURE);
        }
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
    if (*p != '\0') {
        fprintf(stderr, "invalid expression: %s\n", str);
        exit(EXIT_FAILURE);
    }
    return result;
}

void find_exprs(const char* expr, const char* digits, int target) {
    if (digits[0] == '\0') {    // no more attempts
        int n = eval_expr(expr);
        if (n == target)
            add_output(expr);
        return;
    }

    // try all prefixes and operators
    int digits_len = strlen(digits);
    for (int len = 1; len <= digits_len; len++) {

        if (digits[0] == '0' && len > 1) {
            break; // skip leading zeros
        }

        char* new_expr = malloc(strlen(expr) + 1 + len + 1);
        assert(new_expr != NULL);

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

        free(new_expr);
    }
}

void find_all_exprs(const char* digits, int target) {
    find_exprs("", digits, target);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s digits target\n", argv[0]);
        return EXIT_FAILURE;
    }

    find_all_exprs(argv[1], atoi(argv[2]));
    sort_output();
    const char* separator = "";
    for (size_t i = 0; i < output_size; i++) {
        printf("%s%s", separator, output[i]);
        separator = ", ";
    }
    printf("\n");
}
