#include "alloc.h"
#include "utstring.h"
#include <ctype.h>

void capitalize_word(char* p) {
    if (strlen(p) <= 2)
        *p++ = tolower(*p);
    else
        *p++ = toupper(*p);

    while (*p)
        *p++ = tolower(*p);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence", argv[0]);

    UT_string* str;
    utstring_new(str);

    for (int i = 1; i < argc; i++) {
        if (i > 1)
            utstring_printf(str, " ");
        size_t orig_len = utstring_len(str);
        utstring_printf(str, "%s", argv[i]);
        capitalize_word(utstring_body(str) + orig_len);
    }

    printf("%s\n", utstring_body(str));
    utstring_free(str);
}
