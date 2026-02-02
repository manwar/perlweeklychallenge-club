#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void remove_duplicates(char* str) {
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] == str[i+1]) {
            memmove(str+i, str+i+2, strlen(str+i+2)+1);
            i = -1; // will be 0 after continue
            continue;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s str\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* str = strdup(argv[1]);
    assert(str != NULL);
    remove_duplicates(str);
    printf("%s\n", str);
    free(str);
}
