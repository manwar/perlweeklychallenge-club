#include "alloc.h"

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s binary...\n", argv[0]);

    argv++; argc--;

    int value = 0;
    const char *separator = "";
    for (int i = 0; i < argc; i++) {
        int digit = atoi(argv[i]) ? 1 : 0;
        value = 2 * value + digit;
        bool divisible = value % 5 == 0;
        printf("%s%s", separator, divisible ? "true" : "false");
        separator = ", ";
    }
    printf("\n");
}
