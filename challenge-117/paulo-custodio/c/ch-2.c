/*
Challenge 117

TASK #2 - Find Possible Paths
Submitted by: E. Choroba
You are given size of a triangle.

Write a script to find all possible paths from top to the bottom right
corner.

In each step, we can either move horizontally to the right (H), or move
downwards to the left (L) or right (R).

BONUS: Try if it can handle triangle of size 10 or 20.

Example 1:
Input: $N = 2

           S
          / \
         / _ \
        /\   /\
       /__\ /__\ E

Output: RR, LHR, LHLH, LLHH, RLH, LRH
Example 2:
Input: $N = 1

           S
          / \
         / _ \ E

Output: R, LH
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* separator = "";

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void find_paths(int size, const char* path, int row, int col) {
    if (row == size && col == size) {   // reached end
        printf("%s%s", separator, path);
        separator = ", ";
    }
    else {  // recurse
        int len = strlen(path) + 2;
        char* new_path = check_mem(malloc(len));

        if (row < size) {
            sprintf(new_path, "%sL", path);
            find_paths(size, new_path, row + 1, col);

            sprintf(new_path, "%sR", path);
            find_paths(size, new_path, row + 1, col + 1);
        }
        if (col < row) {
            sprintf(new_path, "%sH", path);
            find_paths(size, new_path, row, col + 1);
        }
        free(new_path);
    }
}

int main(int argc, char* argv[]) {
    int size = 1;
    if (argc == 2) size = atoi(argv[1]);
    find_paths(size, "", 0, 0);
    printf("\n");
}
