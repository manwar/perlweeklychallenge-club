#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(a,b) ((a)>(b)?(a):(b))

bool is_number(const char* str) {
    if (*str == '\0')
        return false;
    for (const char* p = str; *p != '\0'; p++) {
        if (!isdigit(*p))
            return false;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fputs("usage: ch-1 strs...\n", stderr);
        exit(EXIT_FAILURE);
    }

    int max = 0;
    for (int i = 1; i < argc; i++) {
        if (is_number(argv[i])) {
            max = MAX(max, atoi(argv[i]));
        }
        else {
            max = MAX(max, strlen(argv[i]));
        }
    }

    printf("%d\n", max);
}
