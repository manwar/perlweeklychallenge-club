#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

int count_char(const char* str, char ch) {
    int count = 0;
    for (const char* p = str; *p; p++) {
        if (*p == ch)
            count++;
    }
    return count;
}

int get_max_row(StrArray* m) {
    int max_row = 0;
    int max_count = 0;
    for (int i = 0; i < m->size; i++) {
        int count = count_char(m->data[i], '1');
        if (count > max_count) {
            max_row = i+1;
            max_count = count;
        }
    }
    return max_row;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s row,row,...", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // get matrix
    StrArray* m = split(args->body, ",");

    // get max 1
    int row = get_max_row(m);
    printf("%d\n", row);

    str_free(args);
    strarray_free(m);
}
