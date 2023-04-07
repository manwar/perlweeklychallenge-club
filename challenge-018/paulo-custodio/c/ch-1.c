/*
Challenge 018

Task #1
Write a script that takes 2 or more strings as command line parameters and
print the longest common substring. For example, the longest common substring
of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC” of length 3.
Other common substrings are “A”, “AB”, “B”, “BA”, “BC” and “C”. Please check
this wiki page for details.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// string array
typedef struct {
    size_t count;
    char** strs;
} StringArray;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* strndup(const char* str, size_t len) {
    char* ret = check_mem(malloc(len + 1));
    strncpy(ret, str, len);
    ret[len] = '\0';
    return ret;
}

StringArray* strs_new() {
    StringArray* arr = check_mem(calloc(1, sizeof(StringArray)));
    arr->strs = check_mem(calloc(1, sizeof(char*)));
    return arr;
}

void strs_clear(StringArray* arr) {
    for (size_t i = 0; i < arr->count; i++)
        free(arr->strs[i]);
    arr->count = 0;
    arr->strs[0] = NULL;
}

void strs_free(StringArray* arr) {
    strs_clear(arr);
    free(arr->strs);
    free(arr);
}

void strs_push(StringArray* arr, const char* str) {
    arr->strs = check_mem(realloc(arr->strs, (arr->count + 2) * sizeof(char*)));
    arr->strs[arr->count++] = check_mem(strdup(str));
    arr->strs[arr->count] = NULL;
}

void strs_pop(StringArray* arr) {
    free(arr->strs[--arr->count]);
    arr->strs[arr->count] = NULL;
}

int compare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

void strs_sort(StringArray* arr) {
    qsort(arr->strs, arr->count, sizeof(char*), compare);
}

StringArray* longest_substrs(int count, char* strs[]) {
    StringArray* subs = strs_new();
    size_t longest_len = 0;

    for (const char* p = strs[0]; *p; p++) {                // starting point
        for (size_t len = strlen(p); len > 1; len--) {      // each length
            if (len >= longest_len) {                       // prune search
                char* sub = strndup(p, len);
                bool in_all = true;                         // find in all
                for (int i = 1; i < count; i++) {
                    if (strstr(strs[i], sub) == NULL) {
                        in_all = false;
                        break;
                    }
                }
                if (in_all) {
                    if (len > longest_len) {
                        strs_clear(subs);
                        strs_push(subs, sub);
                        longest_len = len;
                    }
                    else if (len == longest_len) {
                        strs_push(subs, sub);
                    }
                }
                free(sub);
            }
        }
    }
    strs_sort(subs);
    return subs;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("usage: ch-1 strs...", stderr);
        return EXIT_FAILURE;
    }

    StringArray* subs = longest_substrs(argc - 1, argv + 1);
    printf("(");
    for (size_t i = 0; i < subs->count; i++)
        printf("%s\"%s\"", i == 0 ? "" : ", ", subs->strs[i]);
    printf(")\n");

    strs_free(subs);
}
