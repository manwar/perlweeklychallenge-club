#pragma once

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

#define die(msg, ...) do { \
            fprintf(stderr, msg, ##__VA_ARGS__); \
            fprintf(stderr, "\n"); \
            exit(EXIT_FAILURE); \
        } while (false)

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
