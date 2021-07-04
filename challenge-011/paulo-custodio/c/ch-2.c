/*
Challenge 011

Challenge #2
Write a script to create an Indentity Matrix for the given size. For example,
if the size is 4, then create Identity Matrix 4x4. For more information about
Indentity Matrix, please read the wiki page.
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

int** identity_matrix(int n) {
    int** id = check_mem(malloc(n * sizeof(int*)));
    for (int i = 0; i < n; i++) {
        id[i] = check_mem(calloc(n, sizeof(int)));
        id[i][i] = 1;
    }
    return id;
}

void print_matrix(int** m, int n) {
    printf("[");
    const char* row_sep = "";
    for (int row = 0; row < n; row++) {
        printf("%s[", row_sep);
        row_sep = ",\n ";
        const char* col_sep = "";
        for (int col = 0; col < n; col++) {
            printf("%s%d", col_sep, m[row][col]);
            col_sep = ", ";
        }
        printf("]");
    }
    printf("]\n");
}

void free_matrix(int** m, int n) {
    for (int i = 0; i < n; i++)
        free(m[i]);
    free(m);
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2)
        n = atoi(argv[1]);
    if (n < 1)
        n = 4;

    int** id = identity_matrix(n);
    print_matrix(id, n);
    free_matrix(id, n);
}
