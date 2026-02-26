#include "alloc.h"

Str* echo(const char* str) {
    Str* output = str_new();
    for (int i = 0; str[i] != '\0'; i++) {
        for (int j = 0; j < i+1; j++) {
            str_printf(output, "%c", str[i]);
        }
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    Str* str = echo(argv[1]);
    printf("%s\n", str->body);
    str_free(str);
}
