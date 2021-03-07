/*
Challenge 100

TASK #2 > Triangle Sum
Submitted by: Mohammad S Anwar
You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index i on the current row then you may move to either
index i or index i + 1 on the next row.

Example 1:
Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
Output: 8

Explanation: The given triangle

            1
           2 4
          6 4 9
         5 1 7 2

The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

             [1]
           [2]  4
           6 [4] 9
          5 [1] 7 2
Example 2:
Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
Output: 7

Explanation: The given triangle

            3
           3 1
          5 2 3
         4 3 1 3

The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

             [3]
            3  [1]
           5 [2] 3
          4 3 [1] 3
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

#define MIN(a,b)    ((a)<(b)?(a):(b))

// memory allocation
void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// triangle (stored as a square)
typedef struct {
    int rows;
    int** data;
} Triangle;

Triangle* triangle_new(void) {
    Triangle* triangle = check_mem(calloc(1, sizeof(Triangle)));
    return triangle;
}

void triangle_free(Triangle* triangle) {
    for (int i = 0; i < triangle->rows; i++)
        free(triangle->data[i]);
    free(triangle->data);
    free(triangle);
}

void triangle_add_row(Triangle* triangle) {
    triangle->rows++;
    triangle->data = check_mem(realloc(triangle->data,
        triangle->rows * sizeof(int*)));
    triangle->data[triangle->rows - 1] = NULL;
    for (int i = 0; i < triangle->rows; i++)
        triangle->data[i] = check_mem(realloc(triangle->data[i],
            triangle->rows * sizeof(int)));
}

bool triangle_parse_row(Triangle* triangle, int row, const char* text) {
    assert(row >= 0 && row < triangle->rows);
    for (int i = 0; i < triangle->rows; i++) {
        while (*text && !isdigit(*text)) text++;
        if (!isdigit(*text))
            return false;
        triangle->data[row][i] = atoi(text);
        while (*text && isdigit(*text)) text++;
    }
    return true;
}

bool triangle_parse(Triangle* triangle, int argc, char* argv[]) {
    for (int row = 0; row < argc; row++) {
        triangle_add_row(triangle);
        if (!triangle_parse_row(triangle, row,argv[row]))
            return false;
    }
    return true;
}

int triangle_min_sum_1(Triangle* triangle, int sum, int row, int col) {
    sum += triangle->data[row][col];
    if (row + 1 == triangle->rows)
        return sum;
    else {
        int sum1 = triangle_min_sum_1(triangle, sum, row + 1, col);
        int sum2 = triangle_min_sum_1(triangle, sum, row + 1, col + 1);
        return MIN(sum1, sum2);
    }
}

int triangle_min_sum(Triangle* triangle) {
    return triangle_min_sum_1(triangle, 0, 0, 0);
}

int main(int argc, char* argv[]) {
    if (argc == 1) {
        fputs("Usage: ch-2 row row ...", stderr);
        return EXIT_FAILURE;
    }
    argc--; argv++;
    Triangle* triangle = triangle_new();
    if (!triangle_parse(triangle, argc, argv)) {
        fputs("Malformed triangle", stderr);
        return EXIT_FAILURE;
    }
    int sum = triangle_min_sum(triangle);
    printf("%d\n", sum);
    triangle_free(triangle);
}
