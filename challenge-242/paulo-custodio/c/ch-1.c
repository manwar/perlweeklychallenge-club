/*
Challenge 242

Task 1: Missing Members
Submitted by: Mohammad S Anwar
You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

Example 1
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
Example 2
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
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

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
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
    utarray_sort(arr, compare);

    free(text);
    return arr;
}

UT_array* find_not_in(UT_array* arr1, UT_array* arr2) {
    UT_array* result;
    utarray_new(result, &ut_int_icd);

    for (int *p = NULL; (p = utarray_next(arr1, p)) != NULL; ) {
        if (!utarray_find(arr2, p, compare)) {
            if (!utarray_find(result, p, compare)) {
                utarray_push_back(result, p);
            }
        }
    }

    return result;
}

void print_list(UT_array* arr) {
    printf("[");
    const char* sep = "";
    for (int *p = NULL; (p = utarray_next(arr, p)) != NULL; ) {
        printf("%s%d", sep, *p);
        sep = ", ";
    }
    printf("]");
}

void print_result(UT_array* arr1, UT_array* arr2) {
    printf("(");
    const char* sep = "";

    if (utarray_len(arr1) > 0) {
        printf("%s", sep);
        print_list(arr1);
        sep = ", ";
    }

    if (utarray_len(arr2) > 0) {
        printf("%s", sep);
        print_list(arr2);
        sep = ", ";
    }

    printf(")");
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("Usage: ch-1 '(a,b,c)' '(d,e,f)'");

    UT_array* arr1 = parse_list(argv[1]);
    UT_array* arr2 = parse_list(argv[2]);

    UT_array* not_in1 = find_not_in(arr1, arr2);
    UT_array* not_in2 = find_not_in(arr2, arr1);

    print_result(not_in1, not_in2);

    utarray_free(arr1);
    utarray_free(arr2);
    utarray_free(not_in1);
    utarray_free(not_in2);
}
