#include "alloc.h"

#define Kaprekar 6174

int num_steps(int n) {
    bool seen[10000] = {false};
    int steps = 0;
    while (n != Kaprekar) {
        if (n < 0 || n > 9999) {
            return -1; // Invalid input
        }
        if (seen[n]) {
            return -1; // Cycle detected
        }
        seen[n] = true;
        char str[5];
        sprintf(str, "%04d", n);
        char asc[5], desc[5];
        strcpy(asc, str);
        strcpy(desc, str);
        // Sort ascending
        for (int i = 0; i < 4 - 1; i++) {
            for (int j = i + 1; j < 4; j++) {
                if (asc[i] > asc[j]) {
                    char temp = asc[i];
                    asc[i] = asc[j];
                    asc[j] = temp;
                }
            }
        }
        // Sort descending
        for (int i = 0; i < 4 - 1; i++) {
            for (int j = i + 1; j < 4; j++) {
                if (desc[i] < desc[j]) {
                    char temp = desc[i];
                    desc[i] = desc[j];
                    desc[j] = temp;
                }
            }
        }
        int small = atoi(asc);
        int large = atoi(desc);
        n = large - small;
        steps++;
    }

    return steps;
}

int main(int argc, char *argv[]) {
    if (argc != 2)
        die("Usage: %s n", argv[0]);

    int steps = num_steps(atoi(argv[1]));
    printf("%d\n", steps);
}
