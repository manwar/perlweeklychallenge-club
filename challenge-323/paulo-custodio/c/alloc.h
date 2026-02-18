#pragma once

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define bool_to_string(b) ((b) ? "true" : "false")

#define Epsilon 1.0e-9

static void die(const char* fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(EXIT_FAILURE);
}

static void* _check_ptr(void* p) {
    if (p == NULL)
        die("out of memory");
    return p;
}

#define xmalloc(size)           _check_ptr(malloc(size))
#define xrealloc(mem, size)     _check_ptr(realloc((mem), (size)))
#define xcalloc(count, size)    _check_ptr(calloc((count), (size)))
#define xstrdup(str)            ((char*)_check_ptr(strdup(str)))
#define xfree(mem)              (free(mem), (void)((mem) = NULL))
#define xnew(Type)              xcalloc(1, sizeof(Type))

static char* xstrndup(const char* str, size_t len) {
    char* mem = xmalloc(len+1);
    strncpy(mem, str, len);
    mem[len] = '\0';
    return mem;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} IntArray;

static IntArray* intarray_new() {
    IntArray* arr = xnew(IntArray);
    arr->size = 0;
    arr->capacity = 8;
    arr->data = xmalloc(arr->capacity * sizeof(int));
    return arr;
}

static void intarray_free(IntArray* arr) {
    xfree(arr->data);
    xfree(arr);
}

static void intarray_clear(IntArray* arr) {
    arr->size = 0;
}

static void intarray_grow_capacity(IntArray* arr) {
    int old_capacity = arr->capacity;
    arr->capacity = 2 * old_capacity;
    arr->data = xrealloc(arr->data, arr->capacity * sizeof(int));
}

static void intarray_resize(IntArray* arr, int size) {
    while (size > arr->capacity)
        intarray_grow_capacity(arr);
    arr->size = size;
}

static int intarray_front(IntArray* arr) {
    assert(arr->size > 0);
    return arr->data[0];
}

static int intarray_back(IntArray* arr) {
    assert(arr->size > 0);
    return arr->data[arr->size - 1];
}

static void intarray_push_back(IntArray* arr, int n) {
    intarray_resize(arr, arr->size + 1);
    arr->data[arr->size - 1] = n;
}

static int intarray_pop_back(IntArray* arr) {
    assert(arr->size > 0);
    return arr->data[--arr->size];
}

static void intarray_push_front(IntArray* arr, int n) { // Note: expensive
    intarray_resize(arr, arr->size + 1);
    memmove(arr->data + 1, arr->data, (arr->size - 1) * sizeof(int));
    arr->data[0] = n;
}

static int intarray_pop_front(IntArray* arr) { // Note: expensive
    assert(arr->size > 0);
    int ret = arr->data[0];
    memmove(arr->data, arr->data + 1, (arr->size - 1) * sizeof(int));
    arr->size--;
    return ret;
}

static int int_compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

static void intarray_sort(IntArray* arr) {
    qsort(arr->data, arr->size, sizeof(int), int_compare);
}

static void intarray_reverse(IntArray* arr) {
    for (int i = 0; i < arr->size/2; i++) {
        int t = arr->data[i];
        arr->data[i] = arr->data[arr->size - 1 - i];
        arr->data[arr->size - 1 - i] = t;
    }
}

static void intarray_print(IntArray* arr) {
    const char* separator = "";
    for (int i = 0; i < arr->size; i++) {
        printf("%s%d", separator, arr->data[i]);
        separator = ", ";
    }
    printf("\n");
}

typedef struct {
    int** data;
    int rows;
    int cols;
} IntMatrix;

static IntMatrix* intmatrix_new(int rows, int cols) {
    assert(rows > 0);
    assert(cols > 0);
    IntMatrix* mat = xnew(IntMatrix);
    mat->rows = rows;
    mat->cols = cols;
    mat->data = xcalloc(rows, sizeof(int*));
    for (int r = 0; r < rows; r++)
        mat->data[r] = xcalloc(cols, sizeof(int));
    return mat;
}

static void intmatrix_free(IntMatrix* mat) {
    for (int r = 0; r < mat->rows; r++)
        xfree(mat->data[r]);
    xfree(mat->data);
    xfree(mat);
}

typedef struct {
    char* body;
    int size;
    int capacity;
} Str;

static Str* str_new() {
    Str* str = xnew(Str);
    str->size = 0;
    str->capacity = 64;
    str->body = xmalloc(str->size);
    str->body[0] = '\0';
    return str;
}

static void str_free(Str* str) {
    xfree(str->body);
    xfree(str);
}

static void str_sync_size(Str* str) {
    str->size = strlen(str->body);
}

static void str_clear(Str* str) {
    str->body[0] = '\0';
    str->size = 0;
}

static void str_grow_capacity(Str* str) {
    int old_capacity = str->capacity;
    str->capacity = 2 * old_capacity;
    str->body = xrealloc(str->body, str->capacity);
}

static void str_reserve(Str* str, int needed) {
    while (str->size + needed > str->capacity)
        str_grow_capacity(str);
}

static void str_append(Str* str, const char* text) {
    int needed = strlen(text) + 1;
    str_reserve(str, needed);
    strcpy(str->body + str->size, text);
    str_sync_size(str);
}

static void str_printf(Str* str, const char* fmt, ...) {
    char buffer[BUFSIZ];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, ap);
    va_end(ap);
    str_append(str, buffer);
}

typedef struct {
    char** data;
    int size;
    int capacity;
} StrArray;

static StrArray* strarray_new() {
    StrArray* arr = xnew(StrArray);
    arr->size = 0;
    arr->capacity = 8;
    arr->data = xmalloc(arr->capacity * sizeof(char*));
    return arr;
}

static void strarray_clear(StrArray* arr) {
    for (int i = 0; i < arr->size; i++)
        xfree(arr->data[i]);
    arr->size = 0;
}

static void strarray_free(StrArray* arr) {
    strarray_clear(arr);
    xfree(arr->data);
    xfree(arr);
}

static void strarray_grow_capacity(StrArray* arr) {
    int old_capacity = arr->capacity;
    arr->capacity = 2 * old_capacity;
    arr->data = xrealloc(arr->data, arr->capacity * sizeof(char*));
}

static void strarray_resize(StrArray* arr, int size) {
    while (size > arr->capacity)
        strarray_grow_capacity(arr);
    int old_size = arr->size;
    arr->size = size;
    for (int i = old_size; i < arr->size; i++)
        arr->data[i] = NULL;
}

static char* strarray_front(StrArray* arr) {
    assert(arr->size > 0);
    return arr->data[0];
}

static char* strarray_back(StrArray* arr) {
    assert(arr->size > 0);
    return arr->data[arr->size - 1];
}

static void strarray_push_back(StrArray* arr, const char* str) {
    strarray_resize(arr, arr->size + 1);
    arr->data[arr->size - 1] = xstrdup(str);
}

static void strarray_pop_back(StrArray* arr) {
    assert(arr->size > 0);
    xfree(arr->data[--arr->size]);
}

static void strarray_push_front(StrArray* arr, const char* str) {   // Note: expensive
    strarray_resize(arr, arr->size + 1);
    memmove(arr->data + 1, arr->data, (arr->size - 1) * sizeof(char*));
    arr->data[0] = xstrdup(str);
}

static void strarray_pop_front(StrArray* arr) { // Note: expensive
    assert(arr->size > 0);
    xfree(arr->data[0]);
    memmove(arr->data, arr->data + 1, (arr->size - 1) * sizeof(char*));
    arr->size--;
}

static int str_compare(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

static int str_icompare(const void* a, const void* b) {
    return stricmp(*(char**)a, *(char**)b);
}

static void strarray_sort(StrArray* arr) {
    qsort(arr->data, arr->size, sizeof(char*), str_compare);
}

static void strarray_isort(StrArray* arr) {
    qsort(arr->data, arr->size, sizeof(char*), str_icompare);
}

static void strarray_reverse(StrArray* arr) {
    for (int i = 0; i < arr->size/2; i++) {
        char* t = arr->data[i];
        arr->data[i] = arr->data[arr->size - 1 - i];
        arr->data[arr->size - 1 - i] = t;
    }
}

static void strarray_print(StrArray* arr) {
    const char* separator = "";
    for (int i = 0; i < arr->size; i++) {
        printf("%s%s", separator, arr->data[i]);
        separator = ", ";
    }
    printf("\n");
}
