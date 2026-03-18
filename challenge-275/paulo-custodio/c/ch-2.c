// Perl Weekly Challenge 275 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-275/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* expand_string(const char* input) {
    char last_letter = '\0';
    Str* output = str_new();
    for (const char* p = input; *p; p++) {
        if (isalpha(*p)) {
            last_letter = *p;
            str_printf(output, "%c", *p);
        }
        else if (isdigit(*p) && last_letter != '\0') {
            str_printf(output, "%c", last_letter + *p - '0');
        }
        // ignore other character classes
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    Str* output = expand_string(argv[1]);
    printf("%s\n", output->body);
    str_free(output);
}
