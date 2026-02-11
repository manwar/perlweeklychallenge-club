#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void remove_dups(char* str) {
    int write = 0;
    for (int read = 0; str[read] != '\0'; read++) {
        if (write > 0 && tolower(str[read]) == tolower(str[write - 1]) && str[read] != str[write - 1]) {
            write--;
        } else {
            str[write++] = str[read];
        }
    }
    str[write] = '\0';
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* str = strdup(argv[1]);
    assert(str);
    remove_dups(str);
    printf("%s\n", str);
    free(str);
}
