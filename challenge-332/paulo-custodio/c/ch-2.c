#include "alloc.h"

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
    if (argc != 2)
        die("usage: %s string", argv[0]);

    bool odd = odd_letters(argv[1]);
    printf("%s\n", odd ? "true" : "false");
}
