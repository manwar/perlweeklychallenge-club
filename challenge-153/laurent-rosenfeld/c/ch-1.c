#include <stdio.h>

int main () {
    int sum = 1;
    int fact = 1;
    for (int i = 1; i <= 10; i++) {
        printf("%d ", sum);
        fact *= i;
        sum += fact;
    }
    printf ("\n");
    return 0;
}
