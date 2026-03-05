#include "alloc.h"

bool isvowel(char a) {
    a = tolower(a);
    return a=='a' || a=='e' || a=='i' || a=='o' || a=='u';
}

int count_vowels(const char* str, int len) {
    int count = 0;
    for (int i = 0; i < len; i++) {
        if (isvowel(str[i]))
            count++;
    }
    return count;
}

bool can_split_equal_vowels(const char* str) {
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        int count_left  = count_vowels(str, i);
        int count_right = count_vowels(str+i, len-i);
        if (count_left == count_right)
            return true;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++) {
        str_printf(args, "%s ", argv[i]);
    }

    bool ok = can_split_equal_vowels(args->body);
    printf("%s\n", bool_to_string(ok));

    str_free(args);
}
