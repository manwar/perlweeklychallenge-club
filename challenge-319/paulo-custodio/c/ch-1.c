#include "alloc.h"
#include <ctype.h>

bool is_vowel(char c) {
    c = tolower(c);
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

bool starts_or_ends_vowel(const char* str) {
    int len = strlen(str);
    if (len == 0)
        return false;
    if (is_vowel(str[0]))
        return true;
    if (is_vowel(str[len-1]))
        return true;
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s strings...", argv[0]);

    int count = 0;
    for (int i = 1; i < argc; i++) {
        if (starts_or_ends_vowel(argv[i]))
            count++;
    }

    printf("%d\n", count);
}


