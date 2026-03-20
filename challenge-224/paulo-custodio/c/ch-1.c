// Perl Weekly Challenge 224 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-224/

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

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s source target", argv[0]);

    bool ok = can_create_target(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}
