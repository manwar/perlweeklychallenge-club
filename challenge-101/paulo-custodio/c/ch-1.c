/*
Challenge 101

TASK #1 › Pack a Spiral
Submitted by: Stuart Little

You are given an array @A of items (integers say, but they can be anything).

Your task is to pack that array into an MxN matrix spirally counterclockwise,
as tightly as possible.

‘Tightly’ means the absolute value |M-N| of the difference has to be as small
as possible.
*/

#include <stdio.h>
#include <stdlib.h>

int numbers_width;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int* collect_numbers(int argc, char* argv[]) {
    int* numbers = check_mem(malloc(argc * sizeof(int)));
    for (int i = 0; i < argc; i++) {
        numbers[i] = atoi(argv[i]);
        if (numbers[i] >= 1000 && numbers_width < 4) numbers_width = 4;
        else if (numbers[i] >= 100 && numbers_width < 3) numbers_width = 3;
        else if (numbers[i] >= 10 && numbers_width < 2) numbers_width = 2;
        else if (numbers_width < 1) numbers_width = 1;
    }
    return numbers;
}

void smallest_rect(int n, int* width, int* height) {
    *width = 1; *height = n;
    for (int i = 1; i <= n; i++) {
        if ((n % i) == 0) {
            *width = i; *height = n / i;
            if (*width >= *height)
                break;
        }
    }
}

int** make_empty_rect(int width, int height) {
    int**rect = check_mem(malloc(height * sizeof(int*)));
    for (int r = 0; r < height; r++) {
        rect[r] = check_mem(malloc(width * sizeof(int)));
        for (int c = 0; c < width; c++)
            rect[r][c] = -1;
    }
    return rect;
}

void free_rect(int**rect, int height) {
    for (int r = 0; r < height; r++)
        free(rect[r]);
    free(rect);
}

void fill_spiral(int width, int height, int** rect, int count, int* numbers) {
    int i = 0;
    int r = height - 1;
    int c = 0;
    while (i < count) {
        // go East
        while (c < width && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            c++;
        }
        c--; r--;

        // go North
        while (r >= 0 && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            r--;
        }
        r++; c--;

        // go West
        while (c >= 0 && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            c--;
        }
        c++; r++;

        // go South
        while (r < height && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            r++;
        }
        r--; c++;
    }
}

void print_spiral(int width, int height, int** rect) {
    for (int r = 0; r < height; r++) {
        for (int c = 0; c < width; c++)
            printf("%*d", numbers_width + 1, rect[r][c]);
        putchar('\n');
    }
}

void spiral(int count, char* nums[]) {
    int* numbers = collect_numbers(count, nums);
    int height, width;
    smallest_rect(count, &width, &height);
    int** rect = make_empty_rect(width, height);
    fill_spiral(width, height, rect, count, numbers);
    print_spiral(width, height, rect);
    free(numbers);
    free_rect(rect, height);
}

int main(int argc, char* argv[]) {
    if (argc == 1) {
        fputs("Usage: ch-1 N...", stderr);
        exit(EXIT_FAILURE);
    }
    else
        spiral(--argc, ++argv);
}
