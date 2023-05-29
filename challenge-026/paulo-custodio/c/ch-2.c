/*
Challenge 026

Task #2
Create a script that prints mean angles of the given list of angles in degrees.
Please read wiki page that explains the formula in details with an example.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory\n", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

double mean_angle(double *angles, size_t size) {
    double y = 0.0, x = 0.0;
    for (size_t i = 0; i < size; i++) {
        x += cos(angles[i] * M_PI / 180.0);
        y += sin(angles[i] * M_PI / 180.0);
    }

    return atan2(y / (double)size, x / (double)size) * 180.0 / M_PI;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("usage: ch-2 angles...\n", stderr);
        return EXIT_FAILURE;
    }

    size_t size = argc-1;
    double* angles = check_mem(malloc(size * sizeof(double)));
    for (size_t i = 0; i < size; i++)
        angles[i] = atof(argv[i+1]);

    printf("%.1f", mean_angle(angles, size));

    free(angles);
}
