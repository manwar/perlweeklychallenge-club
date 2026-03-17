// Perl Weekly Challenge 272 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-272/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* defang_ip_address(const char* input) {
    Str* output = str_new();
    for (const char* p = input; *p; p++) {
        if (*p == '.')
            str_append(output, "[.]");
        else
            str_printf(output, "%c", *p);
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s ip_address", argv[0]);

    Str* defangged = defang_ip_address(argv[1]);
    printf("%s\n", defangged->body);
    str_free(defangged);
}
