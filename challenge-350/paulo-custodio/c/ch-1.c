#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define FindLength 3

bool is_good(const char* str, size_t len) {
    bool found[UCHAR_MAX] = {false};
    for (size_t i = 0; i < len; i++) {
        char c = str[i];
        if (found[c])
            return false;
        found[c] = true;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s str\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *str = argv[1];
    size_t len = strlen(str);
    int count = 0;
    if (len >= FindLength) {
        for (size_t i = 0; i <= strlen(str) - FindLength; i++) {
            if (is_good(str+i, FindLength))
                count++;
        }
    }

    printf("%d\n", count);
}
