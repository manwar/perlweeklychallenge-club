#include <stdio.h>

int check_squares (int p[]) {
    int sum = p[0] + p[1];
    return ( p[1] + p[2] + p[3] == sum &&
        p[3] + p[4] + p[5] == sum &&
        p[5] + p[6] == sum);
}

void swap (int a[], int m, int n) {
    int temp = a[m];
    a[m] = a[n];
    a[n] = temp;
}

int main() {
    int in[7] = {7, 6, 5, 4, 3, 2, 1}; # values must be in descending order
    int i, j;
    int fact = 5040;        //factorial 7
    while (fact--) {
        if (check_squares(in)) {
            for (int i = 0; i < 6; i++) printf("%d ", in[i]);
            printf("%d\n", in[6]);
        }
        i = 1;
        while (in[i] > in[i-1]) i++;
        j = 0;
        while (in[j] < in[i]) j++;
        swap(in, i, j);
        i--;
        for (j = 0; j < i; i--, j++) swap(in, i, j);
    }
}
