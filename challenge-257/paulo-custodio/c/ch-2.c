#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void skip_spaces(const char** p) {
    while (isspace(**p))
        (*p)++;
}

void match(const char** p, const char* text) {
    skip_spaces(p);
    if (strncmp(*p, text, strlen(text) != 0))
        die("expected '%s', found '%s'", text, *p);
    (*p) += strlen(text);
}

int parse_number(const char** p) {
    int num = 0;
    int sign = 1;
    skip_spaces(p);
    if (**p == '-') {
        sign = -1;
        (*p)++;
    }
    if (!isdigit(**p))
        die("expected number, found '%c'", **p);
    while (isdigit(**p)) {
        num = 10*num + **p - '0';
        (*p)++;
    }
    return sign * num;
}

int parse_row(const char** p, IntArray* nums) {
    int cols = 0;
    match(p, "[");
    skip_spaces(p);
    while (**p != ']') {
        int num = parse_number(p);
        skip_spaces(p);
        if (**p == ',')
            (*p)++;
        intarray_push_back(nums, num);
        cols++;
    }
    match(p, "]");
    skip_spaces(p);
    if (**p == ',')
        (*p)++;
    return cols;
}

IntMatrix* parse_matrix(const char* str) {
    int rows = 0;
    int cols = 0;
    IntArray* nums = intarray_new();

    const char* p = str;
    match(&p, "[");
    skip_spaces(&p);
    while (*p == '[') {
        const char* row_text = p;
        int row_cols = parse_row(&p, nums);
        if (row_cols == 0)
            die("empty row at '%s'", row_text);
        if (cols == 0)
            cols = row_cols;
        else if (cols != row_cols)
            die("row length %d different from first row length %d", row_cols, cols);
        rows++;
        skip_spaces(&p);
    }
    match(&p, "]");
    skip_spaces(&p);
    if (*p != '\0')
        die("extra input '%s'", p);

    if (rows * cols != nums->size)
        die("expected %d rows and %d cols but only got %d numbers", rows, cols, nums->size);

    // convert to a matrix
    IntMatrix* m = intmatrix_new(rows, cols);
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            m->data[r][c] = nums->data[r * cols + c];
        }
    }
    intarray_free(nums);
    return m;
}

int first_non_zero_col(IntMatrix* m, int row) {
    for (int c = 0; c < m->cols; c++) {
        if (m->data[row][c] != 0)
            return c;
    }
    return -1;
}

bool is_one_alone_in_col(IntMatrix* m, int row, int col) {
    if (m->data[row][col] != 1)
        return false;
    for (int r = 0; r < m->rows; r++) {
        if (r != row) {
            if (m->data[r][col] != 0)
                return false;
        }
    }
    return true;
}

bool is_zero_row(IntMatrix* m, int row) {
    if (first_non_zero_col(m, row) < 0)
        return true;
    else
        return false;
}

bool is_reduced_row_echelon(IntMatrix* m) {
    int last_one_col = -1;
    bool found_zero_row = false;

    for (int row = 0; row < m->rows; row++) {
        if (found_zero_row) {
            if (!is_zero_row(m, row))
                return false;
        }
        else {
            if (is_zero_row(m, row)) {
                found_zero_row = true;
            }
            else {
                int one_col = first_non_zero_col(m, row);
                if (one_col <= last_one_col)
                    return false;
                if (!is_one_alone_in_col(m, row, one_col))
                    return false;
                last_one_col = one_col;
            }
        }
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s matrix", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    IntMatrix* m = parse_matrix(args->body);
    bool ok = is_reduced_row_echelon(m);
    printf("%d\n", ok);

    str_free(args);
    intmatrix_free(m);
}
