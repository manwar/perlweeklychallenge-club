#include <stdio.h>

int main() {
    int a1[] = {1, 2, 3};
    int a2[] = {4, 5, 6};
    int res = 0;
    int size = sizeof(a1)/sizeof(a1[0]);
    for (int i = 0; i < size; i++) {
        res += a1[i] * a2[i];
    }
    printf("%d\n", res);
}
