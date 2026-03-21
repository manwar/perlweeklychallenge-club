// Perl Weekly Challenge 221 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-221/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool can_create_target(const char* source_, const char* target) {
    char* source = xstrdup(source_);
    for (const char* tp = target; *tp; tp++) {
        char* sp = strchr(source, *tp);
        if (sp == NULL) {
            xfree(source);
            return false;
        }
        *sp = ' ';  // use this character
    }
    xfree(source);
    return true;
}

bool is_good(const char* str, const char* chars) {
    return can_create_target(chars, str);
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s words... chars", argv[0]);

    const char* chars = argv[argc-1];
    int sum_len = 0;
    for (int i = 1; i < argc-1; i++) {
        const char* word = argv[i];
        if (is_good(word, chars))
            sum_len += strlen(word);
    }
    printf("%d\n", sum_len);
}
