#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* find_digit(char* str) {
    for (char* p = str; *p; p++) {
        if (isdigit(*p))
            return p;
    }
    return NULL;
}

char* remove_digits(const char* str_) {
    char* str = strdup(str_);
    assert(str);

    char* p = NULL;
    while ((p = find_digit(str)) != NULL) {
        if (p > str)
            memmove(p-1, p+1, strlen(p+1)+1);
        else
            memmove(p, p+1, strlen(p+1)+1);
    }
    return str;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[1]);
        return EXIT_FAILURE;
    }

    char* str = remove_digits(argv[1]);
    printf("%s\n", str);
    free(str);
}
