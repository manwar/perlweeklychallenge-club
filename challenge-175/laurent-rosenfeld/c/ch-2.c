#include <stdio.h>
#define MAX_VAL 50000

int cache[MAX_VAL];

int gcd(int i, int j) {
    while (j != 0) {
        int temp = i % j;
        i = j;
        j = temp;
    }
    return i;
}

int is_perfect_totient (int num) {
    int tot = 0;
    for (int i = 1; i < num; i++) {
        if (gcd(num, i) == 1) {
            tot++;
        }
    }
    int sum = tot + cache[tot];
    cache[num] = sum;
    return num == sum;
}

int main() {
    int j = 1;
    int count = 0;
    while (count < 20) {
        if (is_perfect_totient(j)) {
            printf("%d ", j);
            count++;
        }
        j++;
    }
    printf("%s\n", " ");
}
