// Perl Weekly Challenge 211 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-211/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define SEPARATORS " ,[]\t\r\n"

IntMatrix* parse_matrix() {
    char line[BUFSIZ];
    int rows = 0;
    int cols = 0;
    IntArray* nums = intarray_new();

    // read all numbers into a linear list
    while (fgets(line, sizeof(line), stdin) != NULL) {
        rows++;
        int col = 0;
        char* p = strtok(line, SEPARATORS);
        while (p != NULL) {
            col++;
            intarray_push_back(nums, atoi(p));
            p = strtok(NULL, SEPARATORS);
        }
        if (cols == 0)
            cols = col;
        else if (cols != col)
            die("inconsistent column numbers");
    }

    // move to a matrix
    IntMatrix* m = intmatrix_new(rows, cols);
    assert(rows * cols == nums->size);
    int i = 0;
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            m->data[r][c] = nums->data[i++];
        }
    }
    intarray_free(nums);
    return m;
}

bool is_toeplitz(IntMatrix* m) {
    // start from top row
    for (int c = 0; c < m->cols; c++) {
        int n = m->data[0][c];
        for (int d = 0; d < m->rows; d++) {
            if (d < m->rows && c+d < m->cols) {
                if (m->data[d][c+d] != n) {
                    return false;
                }
            }
        }
    }

    // start from left column
    for (int r = 0; r < m->rows; r++) {
        int n = m->data[r][0];
        for (int d = 0; d < m->cols; d++) {
            if (r+d < m->rows && d < m->cols) {
                if (m->data[r+d][d] != n) {
                    return false;
                }
            }
        }
    }

    return true;
}

int main() {
    IntMatrix* m = parse_matrix();
    bool ok = is_toeplitz(m);
    printf("%d\n", (int)ok);
    intmatrix_free(m);
}
