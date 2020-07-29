#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int *make_array(const int N) {
    int *a = calloc(N+2, sizeof(int));

    for (int i = 1; i <= N; i++)
        a[i] = 1 + rand() % 50;

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

