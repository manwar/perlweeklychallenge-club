#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int comp (const void * elem1, const void * elem2) {
    int f = *((int*)elem1);
    int s = *((int*)elem2);
    if (f > s) return  1;
    if (f < s) return -1;
    return 0;
}

int normalize (int num) {
    int n = num;
    int len = n <= 9 ? 1 : floor(log10(n)) + 1;
    int d[len];  // array of digits of input number
    char st[len];
    int i = 0;
    while (n > 0) {
        d[i] = n % 10;
        n /= 10;
        i++;
    }
    qsort (d, sizeof(d)/sizeof(*d), sizeof(*d), comp);
    int norm = 0;
    int j = 1;
    for (int i = len - 1; i >= 0; i--) {
        norm += d[i] * j;
        j *= 10;
    }
    return norm;
}

int permuted_multiples (int n) {
    int norm_in = normalize(n);
    for (int i = 6; i > 2; i--)
        if (normalize(n * i) != norm_in) return 0;
    return 1;
}

int main () {
    int i = 1;
    while (1) {
        if (permuted_multiples(i)) {
            printf("%d\n", i);
            break;
        }
        i++;
    }
}
