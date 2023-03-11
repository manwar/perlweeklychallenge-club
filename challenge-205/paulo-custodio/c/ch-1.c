/*
Challenge 205

Task 1: Third Highest
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the Third Highest if found otherwise return the maximum.
Example 1

Input: @array = (5,3,4)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.

Example 2

Input: @array = (5,6)
Output: 6

First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.

Example 3

Input: @array = (5,4,4,3)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.
*/

#include <stdio.h>
#include <stdlib.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int compare_desc(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    int result = 0;

    if (argc > 0) {
        int num_items = argc;
        int* items = check_mem(malloc(num_items * sizeof(int)));

        // parse input numbers
        for (int i = 0; i < num_items; i++)
            items[i] = atoi(argv[i]);

        // sort descending
        qsort(items, num_items, sizeof(int), compare_desc);

        // remove duplicates
        int last = items[0]+1;  // different from first
        int j = 0;
        for (int i = 0; i < num_items; i++) {
            if (items[i] != last)
                items[j++] = last = items[i];
        }
        num_items = j;

        // output
        result = (num_items < 3) ? items[0] : items[2];

        free(items);
    }

    printf("%d\n", result);
    return EXIT_SUCCESS;
}
