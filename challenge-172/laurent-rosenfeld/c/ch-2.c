#include <stdio.h>
#include <stdlib.h>

int compare_int(const void *a,const void *b) {
    int *x = (int *) a;
    int *y = (int *) b;
    return *x - *y;
}

float median (int count, int m[]) {
    if (count % 2) {
        return 1.0 * m[(count -1)/2];
    } else {
        return (m[count/2 -1] + m[count/2])/2.0;
    }
}

int main() {
    int moons[] = {0, 0, 1, 2, 63, 61, 27, 13};
    int size = sizeof(moons)/sizeof(*moons);
    qsort (moons, size, sizeof(*moons), compare_int);
    float min = 1.0 * moons[0];
    float med = median(size, moons);
    int half = (int)size/2;
    float first_q = median(half, moons);
    float last_q = median(half, moons + 4);
    float max = 1.0 * moons[size - 1];
    printf ("%.2f %.2f %.2f %.2f %.2f", min, first_q, med, last_q, max);
    return 0;
}
