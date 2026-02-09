#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* remove_duplicates(const char* input) {
    char* result = strdup(input);
    assert(result);

    for (int i = 0; result[i+1] != '\0'; i++) {
        while (i >= 0 && result[i] == result[i+1]) {
            // remove duplicates
            memmove(result+i, result+i+2, strlen(result+i+2)+1);
            // try again previous position
            i--;
        }
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* result = remove_duplicates(argv[1]);
    printf("%s\n", result);
    free(result);
}
