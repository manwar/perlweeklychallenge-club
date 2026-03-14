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

void remove_spaces(char* str) {
    int w = 0;
    for (int r = 0; str[r] != '\0'; r++) {
        if (!isspace(str[r]))
            str[w++] = str[r];
    }
    str[w] = '\0';
}

bool is_special_pos(StrArray* rows, int r, int c) {
    if (rows->data[r][c] == '0')
        return false;
    for (int rr = 0; rr < rows->size; rr++) {
        if (rr != r && rows->data[rr][c] != '0')
            return false;
    }
    for (int cc = 0; cc < strlen(rows->data[r]); cc++) {
        if (cc != c && rows->data[r][cc] != '0')
            return false;
    }
    return true;
}

int count_special_pos(StrArray* rows) {
    int count = 0;
    for (int r = 0; r < rows->size; r++) {
        for (int c = 0; c < strlen(rows->data[r]); c++) {
            if (is_special_pos(rows, r, c))
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s row,row,...", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_append(args, argv[i]);

    // get rows, remove blanks
    StrArray* rows = split(args->body, ",");
    for (int i = 0; i < rows->size; i++)
        remove_spaces(rows->data[i]);

    // count special positions
    int count = count_special_pos(rows);
    printf("%d\n", count);

    str_free(args);
    strarray_free(rows);
}
