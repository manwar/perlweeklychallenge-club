// Perl Weekly Challenge 185 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-185/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* convert_mac(const char* addr) {
    Str* result = str_new();
    int len = strlen(addr);
    for (int i = 0; i < len; i++) {
        if (addr[i] == '.')
            continue;
        if (isxdigit(addr[i]) && i+1 < len && isxdigit(addr[i+1])) {
            if (result->size > 0)
                str_append(result, ":");
            str_printf(result, "%c%c", addr[i], addr[i+1]);
            i++;
        }
        else
            die("invalid mac address %s", addr);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s mac", argv[0]);

    Str* converted = convert_mac(argv[1]);
    printf("%s\n", converted->body);

    str_free(converted);
}
