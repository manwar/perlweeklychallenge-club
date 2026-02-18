#include "alloc.h"

void remove_backspace(Str* str) {
    int w = 0;
    for (int r = 0; str->body[r] != '\0'; r++) {
        if (str->body[r] == '#') {
            if (w > 0)
                w--;
        }
        else {
            str->body[w++] = str->body[r];
        }
    }
    str->body[w] = '\0';
    str_sync_size(str);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s str1 str2", argv[0]);

    Str* s1 = str_new(); str_append(s1, argv[1]); remove_backspace(s1);
    Str* s2 = str_new(); str_append(s2, argv[2]); remove_backspace(s2);
    bool equal = strcmp(s1->body, s2->body) == 0;

    printf("%s\n", bool_to_string(equal));

    str_free(s1);
    str_free(s2);
}
