#include <stdio.h>

#define SIZE 50

int fusc[SIZE];

int main(void) {
    int fusc[SIZE];
    fusc[0] = 0;
    fusc[1] = 1;
    for (int i = 2; i < SIZE; i++) {
        fusc[i] = i % 2 ?
            fusc[(i-1)/2 ] + fusc[(i+1)/2] :
            fusc[i/2];
    };
    for (int i = 0; i < SIZE; i++) {
        printf("%d ", fusc[i]);
    }
    printf("\n");
    return 0;
}
