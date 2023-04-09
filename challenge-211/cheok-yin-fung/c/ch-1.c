// The Weekly Challenge 211
// Task 1 Toeplitz Matrix
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char *argv[]) {
    int arr[100][100];
    int row;
    int col;
    FILE *fp;
    if (argc != 2) {
        printf("Usage: %s filename\nnumber_of_rows number_of_columns\n"
                , argv[0]);
        printf("[matrix elements seperated by spaces and newlines]\n");
        exit(EXIT_FAILURE);
    }
    if ((fp = fopen(argv[1], "r")) == NULL) {
        printf("Can't open %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }
    fscanf(fp, "%d %d", &row, &col);
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            fscanf(fp, "%d", &arr[i][j]);
        }
    }
    int kk = row;
    if (kk > col) kk = col;
    int diag = arr[0][0];
    int ans = true;
    for (int k = 0; k < kk && ans; k++) {
        ans = ans && (diag == arr[k][k]);
    }
    if (ans) {printf("true\n");} else {printf("false\n");}
    return 0;
}

