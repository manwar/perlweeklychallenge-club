#include <stdlib.h>
#include <stdio.h>

int hamming(int x, int y) {
    return __builtin_popcount(x ^ y);
}

int hamming_multi(int count, int ints[]) {
    int dist = 0; // Total Hamming distance

    for (int i = 0; i < count - 1; i++)
        for (int j = i + 1; j < count; j++)
            dist += hamming(ints[i], ints[j]);

    return dist;
}

int main(int argc, char **argv) {
    int * ints = malloc(argc * sizeof(int));

    for (int i = 1; i < argc; i++)
        ints[i-1] = atoi(argv[i]);

    printf("%d", hamming_multi(argc, ints));

    return 0;
}
