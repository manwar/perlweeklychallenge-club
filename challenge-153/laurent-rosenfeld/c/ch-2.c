#include <stdio.h>

char is_factorion(int fact[], int num) {
    int sum = 0;
    int n = num;
    while (n > 0) {
        sum += fact[n % 10];
        n /= 10;
    }
    return num == sum;
}

int main() {
    int fact[10];
    fact[0] = 1;
    for (int i = 1; i <= 9; i++) {
        fact[i] = i * fact[i - 1];
    }

    for (int n = 1; n < 50000; n++) {
        if (is_factorion(fact, n)) {
            printf("%d ", n);
        }
    }
    printf("\n");
    return 0;
}
