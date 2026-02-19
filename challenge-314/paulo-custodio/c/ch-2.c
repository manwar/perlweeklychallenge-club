#include "alloc.h"

bool col_is_sorted(StrArray* words, int col) {
    for (int r = 1; r < words->size; r++) {
        if (words->data[r][col] < words->data[r-1][col])
            return false;
    }
    return true;
}

int deleted_cols(StrArray* words) {
    if (words->size == 0)
        return -1;

    int cols = 0;
    int len = strlen(words->data[0]);
    for (int c = 0; c < len; c++) {
        if (!col_is_sorted(words, c))
            cols++;
    }
    return cols;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words", argv[0]);

    int len;
    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++) {
        if (i == 1)
            len = strlen(argv[i]);
        else {
            if (len != strlen(argv[i]))
                die("strings must be of same length");
        }
        strarray_push_back(words, argv[i]);
    }

    int cols = deleted_cols(words);
    printf("%d\n", cols);
    strarray_free(words);
}
