#include "alloc.h"

IntArray* parse_row() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");

    IntArray* row = intarray_new();
    const char* separators = " \t,";
    char* p = strtok(line, separators);
    while (p != NULL) {
        intarray_push_back(row, atoi(p));
        p = strtok(NULL, separators);
    }
    return row;
}

IntMatrix* parse_matrix() {
    IntArray* nums = parse_row();
    IntArray* dimensions = parse_row();
    if (dimensions->size != 2)
        die("invalid data");
    int rows = dimensions->data[0];
    int cols = dimensions->data[1];

    IntMatrix* mat = intmatrix_new(rows, cols);
    int read = 0;
    for (int r = 0; r < mat->rows; r++) {
        for (int c = 0; c < mat->cols; c++) {
            int n = (read < nums->size) ? nums->data[read++] : 0;
            mat->data[r][c] = n;
        }
    }
    intarray_free(nums);
    return mat;
}

int main() {
    IntMatrix* mat = parse_matrix();
    const char* row_separator = "";
    for (int r = 0; r < mat->rows; r++) {
        const char* col_separator = "";
        printf("%s[", row_separator);
        for (int c = 0; c < mat->cols; c++) {
            printf("%s%d", col_separator, mat->data[r][c]);
            col_separator = ", ";
        }
        printf("]");
        row_separator = ", ";
    }
    printf("\n");
    intmatrix_free(mat);
}
