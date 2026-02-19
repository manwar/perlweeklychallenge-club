#include "alloc.h"
#include <ctype.h>

char* reverse_letters(const char* str_) {
    char* str = xstrdup(str_);
    int b = 0;
    int t = strlen(str)-1;
    while (b < t) {
        // skip non-letters
        while (str[b] != '\0' && !isalpha(str[b]))
            b++;
        while (t > 0 && !isalpha(str[t]))
            t--;
        if (!(b < t))
            break;
        // swap
        char c = str[t];
        str[t] = str[b];
        str[b] = c;

        b++;
        t--;
    }
    return str;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);
    char* reversed = reverse_letters(argv[1]);
    printf("%s\n", reversed);
    xfree(reversed);
}
