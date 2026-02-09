#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int **nums;
    int rows;
    int cols;
} Table;

Table* new_table(int rows, int cols) {
    Table* table = malloc(sizeof(Table));
    assert(table);
    table->nums = malloc(rows * sizeof(int*));
    assert(table->nums);
    for (int i = 0; i < rows; i++) {
        table->nums[i] = calloc(cols, sizeof(int));
        assert(table->nums[i]);
    }
    table->rows = rows;
    table->cols = cols;
    return table;
}

void free_table(Table* table) {
    for (int i = 0; i < table->rows; i++)
        free(table->nums[i]);
    free(table->nums);
    free(table);
}

Table* parse_table() {
    int row, col;
    if (scanf("%d %d", &row, &col) != 2) {
        fprintf(stderr, "missing input data\n");
        exit(EXIT_FAILURE);
    }

    Table* table = new_table(row, col);
    while (scanf("%d %d", &row, &col) == 2) {
        // increment row
        for (int c = 0; c < table->cols; c++)
            table->nums[row][c]++;
        // increment col
        for (int r = 0; r < table->rows; r++)
            table->nums[r][col]++;
    }

    return table;
}

int count_odd_cells(Table* table) {
    int count = 0;
    for (int r = 0; r < table->rows; r++) {
        for (int c = 0; c < table->cols; c++) {
            if (table->nums[r][c] % 2 == 1)
                count++;
        }
    }
    return count;
}

int main() {
    Table* table = parse_table();
    int odd = count_odd_cells(table);
    printf("%d\n", odd);
    free_table(table);
}
