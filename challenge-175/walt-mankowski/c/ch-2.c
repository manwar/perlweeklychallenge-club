#include <stdio.h>
#include <stdlib.h>

const int gcd(const int a, const int b) {
    return b ? gcd(b, a % b) : a;
}

int main(int argc, char *argv[]) {
    const int MAX = 6000;
    int *totient = calloc(MAX, sizeof(int));

    for (int n = 2; n <= MAX; n++)
        for (int i = 1; i <= n-1; i++)
            if (gcd(n, i) == 1)
                totient[n]++;

    int perfect[20];
    int i = 2;
    int n = 0;
    while (n < 20 && i < 6000) {
        int tot = totient[i];
        int sum = tot;
        while (tot != 1) {
            if (sum > i)
                break;
            else {
                tot = totient[tot];
                sum += tot;
            }
        }
        if (sum == i)
            perfect[n++] = i;
        i++;
    }
    for (int i = 0; i < 20; i++)
        printf("%d ", perfect[i]);
    printf("\n");
}
