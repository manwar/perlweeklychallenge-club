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

    char buf1[BUFSIZ] = {0};
    for (int i = 1; i < argc; i++)
        strcat(buf1, argv[i]);
    remove_non_digits(buf1);

    char buf2[BUFSIZ];
    format_number(buf1, buf2);

    printf("%s\n", buf2);
}
