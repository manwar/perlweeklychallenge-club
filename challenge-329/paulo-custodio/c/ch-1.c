#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void blank_non_digits(char* str) {
    for (char* p = str; *p ; p++) {
        if (!isdigit(*p))
            *p = ' ';
    }
}

bool find_number(int* nums, int count, int needle) {
    for (int i = 0; i < count; i++) {
        if (nums[i] == needle)
            return true;
    }
    return false;
}

int* append_number(int* nums, int* count, int number) {
    if (find_number(nums, *count, number))
        return nums;
    (*count)++;
    nums = realloc(nums, (*count)*sizeof(int));
    assert(nums);
    nums[(*count)-1] = number;
    return nums;
}

int* find_numbers(char* str, int* count) {
    blank_non_digits(str);
    int* nums = NULL;
    *count = 0;
    char* p = strtok(str, " ");
    while (p != NULL) {
        int number = atoi(p);
        nums = append_number(nums, count, number);
        p = strtok(NULL, " ");
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    int count = 0;
    int* nums = find_numbers(argv[1], &count);
    for (int i = 0; i < count; i++) {
        if (i > 0)
            printf(", ");
        printf("%d", nums[i]);
    }
    printf("\n");
    free(nums);
}
