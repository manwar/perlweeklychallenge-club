/*
Challenge 204

Task 2: Reshape Matrix
Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.

Example 1

Input: [ 1 2 ]
       [ 3 4 ]

       $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
       $r = 1
       $c = 4

Output: [ 1 2 3 4 ]

Example 2

Input: [ 1 2 3 ]
       [ 4 5 6 ]

       $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
       $r = 3
       $c = 2

Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

        [ 1 2 ]
        [ 3 4 ]
        [ 5 6 ]

Example 3

Input: [ 1 2 ]

       $matrix = [ [ 1, 2 ] ]
       $r = 3
       $c = 2

Output: 0
*/

#define MAX_DATA    1024
#define BLANKS      " \t\r\n\v\f"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int data[MAX_DATA], size = 0, rows = 0, cols = 0;

void parse_data() {
    char line[MAX_DATA], *p;
    while (fgets(line, sizeof(line), stdin)) {
        if (strchr(line, '[') != NULL) {
            while ((p = strchr(line, '[')) != NULL) *p = ' ';
            while ((p = strchr(line, ']')) != NULL) *p = ' ';
            char* p = strtok(line, BLANKS);
            while (p) {
                assert(size < MAX_DATA);
                data[size++] = atoi(p);
                p = strtok(NULL, BLANKS);
            }
        }
        else {
            char* p = strtok(line, BLANKS);
            assert(p);
            rows = atoi(p);
            p = strtok(NULL, BLANKS);
            assert(p);
            cols = atoi(p);
            break;
        }
    }
}

void output_data() {
    if (size != rows*cols)
        printf("0\n");
    else {
        for (int i = 0; i < rows; i++) {
            printf("[ ");
            for (int j = 0; j < cols; j++) {
                printf("%d ", data[i*cols+j]);
            }
            printf("]\n");
        }
    }
}

int main() {
    parse_data();
    output_data();
}
