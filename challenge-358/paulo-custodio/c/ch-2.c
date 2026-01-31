#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LETTERS ('z'-'a'+1)

char* encrypt(const char* str, int n) {
    char* coded = strdup(str);
    assert(coded != NULL);

    for (char* p = coded; *p != '\0'; p++) {
        if (*p >= 'a' && *p <= 'z') {
            *p = (((*p - 'a') + n + LETTERS) % LETTERS) + 'a';
        }
    }
    return coded;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fputs("usage: ch-1 str n\n", stderr);
        exit(EXIT_FAILURE);
    }

    const char* str = argv[1];
    int n = atoi(argv[2]);

    char* coded = encrypt(str, n);

    printf("%s\n", coded);
    free(coded);
}
