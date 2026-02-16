#include "alloc.h"
#include <ctype.h>

bool is_vowel(char c) {
    c = tolower(c);
    if (strchr("aeiou", c))
        return true;
    else
        return false;
}

int count_vowels(const char* str, int len) {
    int count = 0;
    for (int i = 0; i < len && str[i] != '\0'; i++) {
        if (is_vowel(str[i]))
            count++;
    }
    return count;
}

bool equal_vowels(const char* str) {
    int len = strlen(str);
    if (len % 2 != 0)
        return false;
    int count1 = count_vowels(str, len/2);
    if (count1 == 0)
        return false;
    int count2 = count_vowels(str+len/2, len/2);
    return count1 == count2;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s str\n", argv[0]);

    bool equal = equal_vowels(argv[1]);
    printf("%s\n", bool_to_string(equal));
}
