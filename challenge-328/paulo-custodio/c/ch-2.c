#include "alloc.h"
#include <ctype.h>

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
    if (argc != 2)
        die("usage: %s string", argv[0]);

    char* str = xstrdup(argv[1]);
    remove_dups(str);
    printf("%s\n", str);
    xfree(str);
}
