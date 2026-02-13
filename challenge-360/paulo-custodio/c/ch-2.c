#include "alloc.h"

int compare(const void* a, const void* b) {
    return stricmp(*(const char**)a, *(const char**)b);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    argc--; argv++;
    qsort(argv, argc, sizeof(char*), compare);
    for (int i = 0; i < argc; i++) {
        if (i > 0)
            putchar(' ');
        printf("%s", argv[i]);
    }
    putchar('\n');
}
