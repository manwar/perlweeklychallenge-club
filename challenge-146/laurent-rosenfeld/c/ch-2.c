#include <STDIO>
void parent(int *a, int *b) {
    if (*a < *b) {
        *b -= *a;
    } else {
        *a -= *b;
    }
}

int main (void) {
    int num, denom;

    while (scanf ("%d/%d", &num, &denom) == 2) {
        printf("%d/%d - ", num, denom);
        parent(&num, &denom);
        printf("Parent: %d/%d - ", num, denom);
        parent(&num, &denom);
        printf("Grand-parent: %d/%d \n", num, denom);
    }
    return (0);
}
