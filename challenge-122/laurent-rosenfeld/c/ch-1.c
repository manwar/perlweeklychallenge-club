#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int avg = atoi(argv[1]);
    printf("%5i  ", avg);
    for (int i = 1; i < argc - 1; i++) {
        avg = (avg * i + atoi(argv[i+1])) / (i + 1);
        printf("%3i ", avg);
    };
    printf("\n");
}
