// Perl Weekly Challenge 170 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len-1]))
        str[--len] = '\0';
}

StrArray* read_input() {
    char line[BUFSIZ];
    StrArray* lines = strarray_new();
    while (fgets(line, BUFSIZ, stdin) != NULL) {
        trim(line);
        if (line[0] == '\0')
            continue;
        strarray_push_back(lines, line);
    }
    return lines;
}

char* after_assignment(char* line) {
    char* p = line;
    while (isspace(*p)) p++;
    if (!isalpha(*p)) return NULL;
    while (isalnum(*p)) p++;
    while (isspace(*p)) p++;
    if (*p != '=') return NULL;
    p++;
    while (isspace(*p)) p++;
    return p;
}

bool is_assignment(char* line) {
    return after_assignment(line) != NULL;
}

IntMatrix* parse_matrix(StrArray* lines, int* cur_line) {
    if (*cur_line >= lines->size)
        die("insufficient data");
    if (!is_assignment(lines->data[*cur_line]))
        die("invalid start of matrix: %s", lines->data[*cur_line]);

    const char* separators = " \t[],";
    int rows = 0;
    int cols = 0;
    IntArray* nums = intarray_new();
    int row = 0;
    while (*cur_line < lines->size &&
        (row == 0 || !is_assignment(lines->data[*cur_line]))) {
        char* line = lines->data[*cur_line];
        if (row == 0)
            line = after_assignment(line);
        int col = 0;
        char* p = strtok(line, separators);
        while (p != NULL) {
            col++;
            intarray_push_back(nums, atoi(p));
            p = strtok(NULL, separators);
        }
        if (cols == 0)
            cols = col;
        else if (cols != col)
            die("inconsistent column numbers");
        (*cur_line)++;
        row++;
    }
    rows = row;
    assert(rows * cols == nums->size);
    IntMatrix* m = intmatrix_new(rows, cols);
    int i = 0;
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            m->data[r][c] = nums->data[i++];
        }
    }
    intarray_free(nums);
    return m;
}

void parse_input(IntMatrix** a, IntMatrix** b) {
    StrArray* lines = read_input();
    int cur_line = 0;
    *a = parse_matrix(lines, &cur_line);
    *b = parse_matrix(lines, &cur_line);
    assert(cur_line == lines->size);
}

IntMatrix* kronecker_product(IntMatrix* a, IntMatrix* b) {
    IntMatrix* prod = intmatrix_new(a->rows * b->rows, a->cols * b->cols);
    for (int ar = 0; ar < a->rows; ar++) {
        for (int ac = 0; ac < a->cols; ac++) {
            for (int br = 0; br < b->rows; br++) {
                for (int bc = 0; bc < b->cols; bc++) {
                    int tr = ar*b->rows+br;
                    int tc = ac*b->cols+bc;
                    prod->data[tr][tc] = a->data[ar][ac] * b->data[br][bc];
                }
            }
        }
    }
    return prod;
}

int main() {
    IntMatrix* a;
    IntMatrix* b;
    parse_input(&a, &b);
    IntMatrix* prod = kronecker_product(a, b);
    intmatrix_print(prod);
    intmatrix_free(a);
    intmatrix_free(b);
    intmatrix_free(prod);
}
