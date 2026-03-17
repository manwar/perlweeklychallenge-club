// Perl Weekly Challenge 266 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-266/

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

IntArray* split_ints(const char* str) {
    StrArray* items = split(str, " ");
    IntArray* nums = intarray_new();
    for (int i = 0; i < items->size; i++)
        intarray_push_back(nums, atoi(items->data[i]));
    strarray_free(items);
    return nums;
}

IntMatrix* parse_matrix(const char* str) {
    StrArray* rows = split(str, ",");
    IntMatrix* m = intmatrix_new(rows->size, rows->size);
    for (int r = 0; r < rows->size; r++) {
        IntArray* row = split_ints(rows->data[r]);
        if (row->size != rows->size)
            die("input must be a square matrix");
        for (int c = 0; c < row->size; c++)
            m->data[r][c] = row->data[c];
        intarray_free(row);
    }
    strarray_free(rows);
    return m;
}

bool is_x(IntMatrix* m) {
    for (int r = 0; r < m->rows; r++) {
        for (int c = 0; c < m->cols; c++) {
            bool is_diagonal = r == c || r == m->cols-1 - c;
            if (is_diagonal && m->data[r][c] == 0)
                return false;
            if (!is_diagonal && m->data[r][c] != 0)
                return false;
        }
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s row,row,...", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // get matrix
    IntMatrix* m = parse_matrix(args->body);

    bool ok = is_x(m);
    printf("%s\n", bool_to_string(ok));

    str_free(args);
    intmatrix_free(m);
}
