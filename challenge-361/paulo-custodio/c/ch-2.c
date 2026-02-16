#include "alloc.h"

IntArray* parse_row(char* line) {
    const char* separators = " \t,";
    IntArray* row = intarray_new();
    char* p = strtok(line, separators);
    while (p != NULL) {
        intarray_push_back(row, atoi(p));
        p = strtok(NULL, separators);
    }
    return row;
}

IntMatrix* parse_matrix() {
    char line[BUFSIZ];

    // get first row
    if (!fgets(line, sizeof(line), stdin))
        die("missing input data");

    IntArray* row = parse_row(line);
    if (row->size <= 0)
        die("invalid data");

    IntMatrix* mat = intmatrix_new(row->size, row->size);
    for (int r = 0; r < mat->rows; r++) {
        if (r > 0) {
            // get next row
            if (!fgets(line, sizeof(line), stdin))
                die("missing input data");

            row = parse_row(line);
            if (row->size != mat->cols)
                die("invalid data");
        }

        for (int c = 0; c < mat->cols; c++) {
            mat->data[r][c] = row->data[c];
        }

        intarray_free(row);
    }

    return mat;
}

bool is_celebrity(int celeb, IntMatrix* mat) {
    if (celeb < 0 || celeb >= mat->rows)
        return false;

    // knows no one
    for (int person = 0; person < mat->rows; person++) {
        if (person == celeb)
            continue;
        if (mat->data[celeb][person])
            return false;
    }

    // every one knows
    for (int person = 0; person < mat->rows; person++) {
        if (person == celeb)
            continue;
        if (!mat->data[person][celeb])
            return false;
    }

    return true;
}

int find_celebrity(IntMatrix* mat) {
    for (int celeb = 0; celeb < mat->rows; celeb++) {
        if (is_celebrity(celeb, mat))
            return celeb;
    }
    return -1;
}

int main() {
    IntMatrix* mat = parse_matrix();
    int celeb = find_celebrity(mat);
    printf("%d\n", celeb);
    intmatrix_free(mat);
}
