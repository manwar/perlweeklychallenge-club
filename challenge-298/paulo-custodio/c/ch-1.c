#include "alloc.h"

void remove_blanks(char* text) {
    int write = 0;
    for (int read = 0; text[read] != '\0'; read++) {
        if (!isspace(text[read]))
            text[write++] = text[read];
    }
    text[write] = '\0';
}

StrArray* parse_grid() {
    char line[BUFSIZ];
    StrArray* grid = strarray_new();
    while (fgets(line, sizeof(line), stdin)) {
        remove_blanks(line);
        strarray_push_back(grid, line);
    }
    return grid;
}

int compute_area(StrArray* grid, int row, int col, int height, int width) {
    for (int r = row; r < row+height; r++) {
        for (int c = col; c < col+width; c++) {
            if (grid->data[r][c] != '1')
                return 0;
        }
    }
    return height*width;
}

int compute_max_area(StrArray* grid) {
    int max_area = 0;
    for (int r = 0; r < grid->size; r++) {
        for (int h = 1; r+h <= grid->size; h++) {
            for (int c = 0; c < strlen(grid->data[r]); c++) {
                int w = h;
                if (c+w <= strlen(grid->data[r])) {
                    int area = compute_area(grid, r, c, h, w);
                    max_area = MAX(max_area, area);
                }
            }
        }
    }
    return max_area;
}

int main() {
    StrArray* grid = parse_grid();
    int max_area = compute_max_area(grid);
    printf("%d\n", max_area);
    strarray_free(grid);
}
