#include "alloc.h"

char* pad_string(const char* str, int size) {
    if (strlen(str) > size) {
        return xstrdup(str);
    }

    char* result = xmalloc(size+1);
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
    if (argc != 3)
        die("usage: %s string padding", argv[0]);

    char* padded = pad_string(argv[1], atoi(argv[2]));
    printf("%s\n", padded);
    free(padded);
}
