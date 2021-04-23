#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define DEFAULT_IN 248832

int main(int argc, char *argv[]) {
    printf("%s\n", argv[1]);
    int in = argc == 2 ? atoi( argv[1]) : DEFAULT_IN;
    for (int i = 1; i <= 10; i++) {
        printf("%2i     %10.3f \n", i, pow (in, 1.0/i));
    };
    return 0;
}
