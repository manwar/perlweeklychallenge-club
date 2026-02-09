#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* list;
    int size;
} List;

void init_list(List* list) {
    list->list = NULL;
    list->size = 0;
}

void free_list(List* list) {
    free(list->list);
}

void push_list(List* list, int n) {
    list->size++;
    list->list = realloc(list->list, list->size * sizeof(int));
    assert(list->list);
    list->list[list->size-1] = n;
}

void reverse_list(List* list) {
    for (int i = 0; i < list->size/2; i++) {
        int a = list->list[i];
        int b = list->list[list->size-i-1];
        list->list[i] = b;
        list->list[list->size-i-1] = a;
    }
}

void add_numbers(List* result, List* a, List* b) {
    int carry = 0;
    result->size = 0;
    for (int i = 0; i < a->size || i < b->size; i++) {
        int a_digit = i < a->size ? a->list[i] : 0;
        int b_digit = i < b->size ? b->list[i] : 0;
        int sum = carry + a_digit + b_digit;
        int sum_digit = sum % 10;
        carry = sum / 10;
        push_list(result, sum_digit);
    }
    assert(carry < 10);
    if (carry > 0)
        push_list(result, carry);
}

void parse_number(List* list, const char* str) {
    list->size = 0;
    const char* p = str;
    while (*p != '\0') {
        while (isspace(*p))
            p++;
        if (*p == '\0')
            break;
        if (isdigit(*p)) {
            push_list(list, *p - '0');
            p++;
        }
        else {
            fprintf(stderr, "unexpected character: '%c'\n", *p);
            exit(EXIT_FAILURE);
        }
    }
    reverse_list(list);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s list num\n", stderr);
        return EXIT_FAILURE;
    }

    List a, b, r;
    init_list(&a);
    init_list(&b);
    init_list(&r);

    // get operands
    parse_number(&a, argv[1]);
    parse_number(&b, argv[2]);

    // add
    add_numbers(&r, &a, &b);

    // print - note reverse order
    const char* separator = "";
    for (int i = r.size-1; i >= 0; i--) {
        printf("%s%c", separator, r.list[i] + '0');
        separator = ", ";
    }
    printf("\n");

    free_list(&a);
    free_list(&b);
    free_list(&r);
}
