#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool odd_letters(const char* str) {
    // count letters
    int count[UCHAR_MAX] = {0};
    for (int i = 0; str[i] != '\0'; i++)
        count[str[i]]++;

    // check if all counts odd
    for (int i = 0; i < UCHAR_MAX; i++) {
        if (count[i] == 0)
            continue;
        if (count[i] % 2 == 0)
            return false;
    }

    return true;
}

int main (int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    bool odd = odd_letters(argv[1]);
    printf("%s\n", odd ? "true" : "false");
}
