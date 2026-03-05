#include "alloc.h"

int count_complete_days(IntArray* hours) {
    int count = 0;
    for (int i = 0; i < hours->size - 1; i++) {
        for (int j = i + 1; j < hours->size; j++) {
            if (abs(hours->data[i] - hours->data[j]) % 24 == 0)
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s hours...", argv[0]);

    IntArray* hours = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(hours, atoi(argv[i]));

    int count = count_complete_days(hours);
    printf("%d\n", count);

    intarray_free(hours);
}
