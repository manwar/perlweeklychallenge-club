/*
Challenge 242

Task 2: Flip Matrix
Submitted by: Mohammad S Anwar
You are given n x n binary matrix.

Write a script to flip the given matrix as below.


1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
Example 2
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
*/

#include "utarray.h"
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DELIMS "[](),; \t"

void die(const char* message, ...) {
    va_list ap;
    va_start(ap, message);
    vfprintf(stderr, message, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(EXIT_FAILURE);
}

void* check_mem(void* p) {
    if (!p)
        die("Out of memory");
    return p;
}

UT_array* parse_list(const char* text_) {
    UT_array* arr;
    utarray_new(arr, &ut_int_icd);

    char* text = check_mem(strdup(text_));
    char* token = strtok(text, DELIMS);
    while (token) {
        int n = atoi(token);
        utarray_push_back(arr, &n);
        token = strtok(NULL, DELIMS);
    }

    free(text);
    return arr;
}

UT_array* parse_matrix(const char* text_) {
    char* text = check_mem(malloc(strlen(text_) + 2 + 1));
    sprintf(text, "%s],", text_);

    UT_array* matrix;
    utarray_new(matrix, &ut_ptr_icd);

    char* row_delim;
    char* p = text;
    while ((row_delim = strstr(p, "],")) != NULL) {
        *row_delim = '\0';
        UT_array* row = parse_list(p);
        utarray_push_back(matrix, &row);
        p = row_delim + 1;
    }

    free(text);
    return matrix;
}

void process_matrix(UT_array* matrix) {
    for (UT_array** p = NULL; (p = utarray_next(matrix, p)) != NULL; ) {
        UT_array* row = *p;
        // a) Reverse each row
        for (size_t i = 0; i < utarray_len(row) / 2; i++) {
            int a = *(int*)utarray_eltptr(row, i);
            int b = *(int*)utarray_eltptr(row, utarray_len(row) - 1 - i);
            *(int*)utarray_eltptr(row, i) = b;
            *(int*)utarray_eltptr(row, utarray_len(row) - 1 - i) = a;
        }

        // b) Invert each member
        for (size_t i = 0; i < utarray_len(row); i++) {
            int a = *(int*)utarray_eltptr(row, i);
            *(int*)utarray_eltptr(row, i) = 1 - a;
        }
    }
}

void print_list(UT_array* arr) {
    printf("[");
    const char* sep = "";
    for (int* p = NULL; (p = utarray_next(arr, p)) != NULL; ) {
        printf("%s%d", sep, *p);
        sep = ", ";
    }
    printf("]");
}

void print_matrix(UT_array* matrix) {
    printf("(");
    const char* sep = "";
    for (UT_array** p = NULL; (p = utarray_next(matrix, p)) != NULL; ) {
        printf("%s", sep);
        print_list(*p);
        sep = ", ";
    }
    printf(")");
}

void free_matrix(UT_array* matrix) {
    for (UT_array** p = NULL; (p = utarray_next(matrix, p)) != NULL; ) {
        utarray_free(*p);
        *p = NULL;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("Usage: ch-2 '([a, b, c], [d, e, f], [g, h, i])'");

    UT_array* matrix = parse_matrix(argv[1]);
    process_matrix(matrix);
    print_matrix(matrix);
    free_matrix(matrix);

    utarray_free(matrix);
}
