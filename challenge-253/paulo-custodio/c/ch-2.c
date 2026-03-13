#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int row;
    int num_ones;
} Row;

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

int count_ones(IntMatrix* m, int row) {
    int count = 0;
    for (int col = 0; col < m->cols; col++) {
        if (m->data[row][col] == 1)
            count++;
    }
    return count;
}

int compare(const void* a, const void* b) {
    Row* row_a = (Row*)a;
    Row* row_b = (Row*)b;
    if (row_a->num_ones != row_b->num_ones)
        return row_a->num_ones - row_b->num_ones;
    else
        return row_a->row - row_b->row;
}

IntArray* get_ordered_rows(IntMatrix* m) {
    // collect row data
    Row* rows = xmalloc(m->rows * sizeof(Row));
    for (int row = 0; row < m->rows; row++) {
        rows[row].row = row;
        rows[row].num_ones = count_ones(m, row);
    }

    // sort
    qsort(rows, m->rows, sizeof(Row), compare);

    // collect row ids
    IntArray* row_ids = intarray_new();
    for (int row = 0; row < m->rows; row++) {
        intarray_push_back(row_ids, rows[row].row);
    }

    xfree(rows);
    return row_ids;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s matrix", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    IntMatrix* m = parse_matrix(args->body);

    IntArray* row_ids = get_ordered_rows(m);
    intarray_print(row_ids);

    str_free(args);
    intmatrix_free(m);
    intarray_free(row_ids);
}
