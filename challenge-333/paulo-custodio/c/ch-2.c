#include "alloc.h"

void dup_zeros(const int* from, int* to, int size) {
    int j = 0;
    for (int i = 0; i < size && j < size; i++) {
        to[j++] = from[i];
        if (from[i] == 0 && j < size)
            to[j++] = from[i];
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argc--; argv++;

    int* from = xmalloc(argc * sizeof(int));
    for (int i = 0; i < argc; i++)
        from[i] = atoi(argv[i]);

    int* to = xmalloc(argc * sizeof(int));

    dup_zeros(from, to, argc);

    for (int i = 0; i < argc; i++) {
        if (i > 0)
            printf(", ");
        printf("%d", to[i]);
    }

    xfree(from);
    xfree(to);
}
