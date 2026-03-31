// Perl Weekly Challenge 190 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-190/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define IS_UPPER(c)     (c >= 'A' && c <= 'Z')
#define IS_LOWER(c)     (c >= 'a' && c <= 'z')

bool is_capitalized(const char* text) {
    if (!IS_UPPER(text[0]))
        return false;
    for (int i = 1; text[i] != '\0'; i++) {
        if (!IS_LOWER(text[i]))
            return false;
    }
    return true;
}

bool is_lower(const char* text) {
    for (int i = 0; text[i] != '\0'; i++) {
        if (!IS_LOWER(text[i]))
            return false;
    }
    return true;
}

bool is_upper(const char* text) {
    for (int i = 0; text[i] != '\0'; i++) {
        if (!IS_UPPER(text[i]))
            return false;
    }
    return true;
}

bool is_caps_ok(const char* text) {
    return is_capitalized(text) || is_lower(text) || is_upper(text);
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s word", argv[0]);

    bool ok = is_caps_ok(argv[1]);
    printf("%d\n", (int)ok);
}
