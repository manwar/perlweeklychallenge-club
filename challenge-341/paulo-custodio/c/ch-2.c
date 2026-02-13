#include "alloc.h"

char* reverse_prefix(const char* string, char ch) {
    char* result = xstrdup(string);

    char* p = strchr(result, ch);
    if (p == NULL) {    // char not found
        return result;
    }

    // reverse chars up to p inclusive
    int len = p - result + 1;
    for (int i = 0; i < len/2; i++) {
        char t = result[i];
        result[i] = result[len-1-i];
        result[len-1-i] = t;
    }

    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string char\n", argv[0]);

    char* result = reverse_prefix(argv[1], argv[2][0]);
    printf("%s\n", result);
    xfree(result);
}
