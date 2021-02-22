/*
Challenge 003

Challenge #2
Create a script that generates Pascal Triangle. Accept number of rows from
the command line. The Pascal Triangle should have at least 3 rows. For more
information about Pascal Triangle, check this wikipedia page.

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

void draw_pascal(int rows) {
    // allocate current and next row
    int* data[2];
    for (int i = 0; i < 2; i++)
        data[i] = check_mem(calloc(rows+1, sizeof(int)));

    int cur = 0;
    data[cur][0] = 1;
    for (int row = 1; row <= rows; row++) {
        // print current row
        for (int col = 0; col < rows-row; col++)
            putchar(' ');
        for (int col = 0; col < row; col++)
            printf("%d ", data[cur][col]);
        putchar('\n');

        // compute next row
        int nxt = 1-cur;
        data[nxt][0] = 1;
        data[nxt][row] = 1;
        for (int col = 1; col < row; col++)
            data[nxt][col] = data[cur][col-1] + data[cur][col];
        cur = nxt;
    }

    // free data
    for (int i = 0; i < 2; i++)
        free(data[i]);
}

int main(int argc, char* argv[]) {
    if (argc == 2)
        draw_pascal(atoi(argv[1]));
}
