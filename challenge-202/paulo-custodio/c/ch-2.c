/*
Challenge 202

Task 2: Widest Valley
Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost widest valley.
A valley is defined as a subarray of the profile consisting of two parts:
the first part is non-increasing and the second part is non-decreasing.
Either part can be empty.

Example 1

Input: 1, 5, 5, 2, 8
Output: 5, 5, 2, 8

Example 2

Input: 2, 6, 8, 5
Output: 2, 6, 8

Example 3

Input: 9, 8, 13, 13, 2, 2, 15, 17
Output: 13, 13, 2, 2, 15, 17

Example 4

Input: 2, 1, 2, 1, 3
Output: 2, 1, 2

Example 5

Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
Output: 3, 3, 2, 1, 2, 3, 3
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int largest_valey(int heights[], int heights_size) {
    int l1 = 0, r1 = -1;        // initial interval

    // find largest valey
    for (int c = 0; c < heights_size; c++) {    // center of valey

        int l = c;                              // left
        while (l-1 >= 0 && heights[l-1] >= heights[l])
            l--;

        int r = c;                              // right
        while (r+1 < heights_size && heights[r+1] >= heights[r])
            r++;

        if (r - l + 1 > r1 - l1 + 1) {
            l1 = l;
            r1 = r;
        }
    }

    // return valey in heights array
    memmove(heights, heights+l1, (r1-l1+1)*sizeof(int));
    return r1-l1+1;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 2) {
        fputs("Usage: ch-2 height...\n", stderr);
        return EXIT_FAILURE;
    }

    int heights_size = argc;
    int* heights = check_mem(malloc(heights_size * sizeof(int)));
    for (int i = 0; i < heights_size; i++)
        heights[i] = atoi(argv[i]);

    int width = largest_valey(heights, heights_size);
    for (int i = 0; i < width; i++)
        printf("%d ", heights[i]);
    printf("\n");

    free(heights);
    return EXIT_SUCCESS;
}
