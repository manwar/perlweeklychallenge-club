#include "alloc.h"

char* remove_duplicates(const char* input) {
    char* result = xstrdup(input);
    int write = 0;

    for (int read = 0; result[read] != '\0'; read++) {
        if (write > 0 && result[write-1] == result[read])
            write--;
        else
            result[write++] = result[read];
    }
    result[write] = '\0';
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    char* result = remove_duplicates(argv[1]);
    printf("%s\n", result);
    xfree(result);
}
