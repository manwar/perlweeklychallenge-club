// Perl Weekly Challenge 365 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-365/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_letter(char c) {
    return c >= 'a' && c <= 'z';
}

bool is_punct(char c) {
    return c == '!' || c == '.' || c == ',';
}

bool is_valid(const char* str) {
    int len = strlen(str);
    bool has_hiffen = false;
    for (int i = 0; i < len; i++) {
        if (is_letter(str[i])) {
            // ok
        }
        else if (str[i] == '-' &&
                 !has_hiffen &&
                 i > 0 && is_letter(str[i-1]) &&
                 i < len-1 && is_letter(str[i+1])) {
            has_hiffen = true;
        }
        else if (is_punct(str[i]) && i == len-1) {
            // ok
        }
        else {
            return false;
        }
    }
    return true;
}

int count_valid(int argc, char* argv[]) {
    int count = 0;
    for (int i = 0; i < argc; i++) {
        if (is_valid(argv[i]))
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    int count = count_valid(argc-1, argv+1);
    printf("%d\n", count);
}
