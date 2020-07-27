#include <stdio.h>
#include <stdlib.h>

void init(int *S) {
    S[0] = 0;
    S[1] = 1;
    S[2] = 3;
    S[3] = 2;
}

void gray_code(int n, int *S) {
    int offset = 1 << (n-1);
    for (int i = 0; i < offset; i++)
        S[i + offset] = S[offset-i-1] + offset;
}

int main(int argc, char *argv[]) {
    int n = atoi(argv[1]);
    size_t len = 1 << n;
    int *S = calloc(len, sizeof(int));
    init(S);

    for (int i = 3; i <= n; i++)
        gray_code(i, S);

    for (int i = 0; i < len; i++)
        printf("%d ", S[i]);
    printf("\n");
}
