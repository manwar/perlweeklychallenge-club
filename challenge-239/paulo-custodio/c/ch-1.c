// Perl Weekly Challenge 239 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-239/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool same_strings(const char* args) {
    Str* str1 = str_new();
    Str* str2 = str_new();
    bool found_comma = false;
    for (const char* p = args; *p; p++) {
        if (*p == ',') {
            if (found_comma)
                die("only one comma expected, got %s", args);
            found_comma = true;
        }
        else if (!isspace(*p)) {
            str_printf(found_comma ? str2 : str1, "%c", *p);
        }
    }

    bool same = strcmp(str1->body, str2->body) == 0;
    str_free(str1);
    str_free(str2);
    return same;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s strings... , strings...", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    bool ok = same_strings(args->body);
    printf("%s\n", bool_to_string(ok));
    str_free(args);
}
