#include "alloc.h"
#include <ctype.h>

char* upper_lower(const char* str_) {
    char* str = xstrdup(str_);
    for (int i = 0; str[i] != '\0'; i++) {
        if (isalpha(str[i]))
            str[i] ^= 0x20;
    }
    return str;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);
    char* inverted = upper_lower(argv[1]);
    printf("%s\n", inverted);
    xfree(inverted);
}
