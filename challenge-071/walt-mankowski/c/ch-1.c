#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void fisher_yates(int *a, const int N) {
    for (int i = N-1; i >= 1; i--) {
        const int j = rand() % (i+1);
        const int tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
}

const int *make_array(const int N) {
    int digits[50];
    for (int i = 0; i < 50; i++)
        digits[i] = i+1;

    fisher_yates(digits, 50);

    int *a = calloc(N+2, sizeof(int));
    memcpy(a+1, digits, N * sizeof(int));

    return a;
}

const int *peaks(const int *a, const int N) {
    int *p = calloc(N+2, sizeof(int));
    int j = 1;
    
    for (int i = 1; i <= N; i++) {
        if (a[i-1] < a[i] && a[i] > a[i+1])
            p[j++] = a[i];
    }

    return p;
}

void print_array(const int *a, const int N) {
    for (int i = 1; i <= N; i++) {
        if (a[i] == 0)
            break;
        printf("%d ", a[i]);
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    const int N = atoi(argv[1]);
    const int *a = make_array(N);
    print_array(a, N);
    const int *p = peaks(a, N);
    print_array(p, N);
}

