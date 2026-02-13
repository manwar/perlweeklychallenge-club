#include "alloc.h"
#include <ctype.h>

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
    if (argc < 2)
        die("usage: %s strs...", argv[0]);

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
