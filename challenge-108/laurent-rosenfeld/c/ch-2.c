#include <stdio.h>
#include <stdlib.h>
#define MAX 10

int main() {
    int tr[MAX][MAX];
    tr[0][0] = 1;
    int results[MAX] = {1};
    for (int row = 1; row < MAX; row++) {
        int res = tr[row - 1][row - 1];
        tr[row][0] = res;
        results[row] = res;
        for (int i = 1; i <= row; i++) {
            tr[row][i] = tr[row][i-1] + tr[row - 1][i-1];
        }
    }
    printf("The ten first Bell numbers are: %i ", (results[0]));
    for (int i = 1; i < MAX; i++) {
        printf("%d ", results[i]);
    }
    printf("\n");
    return 0;
}
