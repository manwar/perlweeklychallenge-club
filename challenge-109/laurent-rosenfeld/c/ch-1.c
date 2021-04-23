#include <stdio.h>

int chowla(int n) {
    int sum = 0;
    for (int i = 2; i <= n/2; i++) {
        if (n % i == 0) {
            sum += i;
        }
    }
    return sum;
}

int main() {
    for (int n = 1; n <= 37; n++) {
        printf("%i ", chowla(n));
    }
    printf("\n");
}
