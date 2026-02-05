#include <stdio.h>
#include <stdlib.h>

int sum_digits(int n) {
    int sum = 0;
    while (n > 0) {
        int digit = n % 10;
        n /= 10;
        sum += digit;
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s n\n", argv[0]);
        return EXIT_FAILURE;
    }

    int n = atoi(argv[1]);
    int persistence = 0;
    while (n > 9) {
        n = sum_digits(n);
        persistence++;
    }
    printf("Persistence  = %d\n", persistence);
    printf("Digital Root = %d\n", n);
}
