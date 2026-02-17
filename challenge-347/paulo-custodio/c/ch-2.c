#include "alloc.h"
#include <ctype.h>

void remove_non_digits(char* num) {
    char* from = num;
    char* to = num;
    while (*from != '\0') {
        if (isdigit(*from)) {
            *to++ = *from;
        }
        from++;
    }
    *to = '\0';
}

void format_number(const char* from, char* to) {
    while (strlen(from) > 4) {
        strncpy(to, from, 3);
        from += 3;
        to += 3;
        *to++ = '-';
    }
    if (strlen(from) == 4) {
        strncpy(to, from, 2);
        from += 2;
        to += 2;
        *to++ = '-';
        strcpy(to, from);
    }
    else {
        strcpy(to, from);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s number\n", argv[0]);

    Str* buf1 = str_new();
    for (int i = 1; i < argc; i++) {
        str_append(buf1, argv[i]);
    }
    remove_non_digits(buf1->body);
    str_sync_size(buf1);

    Str* buf2 = str_new();
    str_reserve(buf2, 2 * buf1->size);
    format_number(buf1->body, buf2->body);

    printf("%s\n", buf2->body);

    str_free(buf1);
    str_free(buf2);
}
