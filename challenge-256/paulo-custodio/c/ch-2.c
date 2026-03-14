#include "../../../challenge-001/paulo-custodio/c/alloc.h"

Str* merge_strings(const char* s1, const char* s2) {
    int l1 = strlen(s1);
    int l2 = strlen(s2);
    Str* result = str_new();
    for (int i = 0; i < MAX(l1, l2); i++) {
        if (i < l1)
            str_printf(result, "%c", s1[i]);
        if (i < l2)
            str_printf(result, "%c", s2[i]);
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s word1 word2", argv[0]);

    Str* merged = merge_strings(argv[1], argv[2]);
    printf("%s\n", merged->body);

    str_free(merged);
}
