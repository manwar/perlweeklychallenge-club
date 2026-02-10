#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* pad_string(const char* str, int size) {
    if (strlen(str) > size) {
        char* result = strdup(str);
        assert(result);
        return result;
    }

    char* result = malloc(size+1);
    assert(result);
    int left = (size - strlen(str)) / 2;
    for (int i = 0; i < left; i++)
        result[i] = '*';
    strcpy(result + left, str);
    for (int i = strlen(result); i < size; i++)
        result[i] = '*';
    result[size] = '\0';
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s string padding\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* padded = pad_string(argv[1], atoi(argv[2]));
    printf("%s\n", padded);
    free(padded);
}
