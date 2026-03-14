#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* greatest_letter(const char* str) {
    Str* output = str_new();
    for (char ch = 'Z'; ch >= 'A'; ch--) {
        if (strchr(str, ch) != NULL && strchr(str, tolower(ch)) != NULL) {
            str_printf(output, "%c", ch);
            return output;
        }
    }
    str_append(output, "''");
    return output;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    Str* greatest = greatest_letter(argv[1]);
    printf("%s\n", greatest->body);
    str_free(greatest);
}
