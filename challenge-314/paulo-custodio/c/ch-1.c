#include "alloc.h"

Str* common_prefix(StrArray* words) {
    Str* prefix = str_new();
    for (int c = 0; words->data[0][c] != '\0'; c++) {
        for (int r = 0; r < words->size; r++) {
            if (words->data[r][c] == '\0')
                return prefix;
            if (words->data[r][c] != words->data[0][c])
                return prefix;
        }
        str_printf(prefix, "%c", words->data[0][c]);
    }
    return prefix;
}

int num_ops(StrArray* words) {
    Str* prefix = common_prefix(words);
    if (prefix->size == 0)
        return -1;

    int ops = 0;
    for (int i = 0; i < words->size; i++) {
        ops += strlen(words->data[i]) - prefix->size;
    }

    str_free(prefix);
    return ops;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    int ops = num_ops(words);
    printf("%d\n", ops);

    strarray_free(words);
}
