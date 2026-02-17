#include "alloc.h"
#include <ctype.h>

typedef struct {
    int k;
    size_t rows;
    size_t cols;
    int** matrix;
} Data;

#define SKIP_WS(p) do { while (*(p) != '\0' && isspace(*(p))) { (p)++; } } while(0)

void free_data(Data* data) {
    if (data != NULL) {
        for (size_t i = 0; i < data->rows; i++) {
            free(data->matrix[i]);
        }
        free(data->matrix);
        free(data);
    }
}

const char* scan_name_equal(const char* line, const char* name) {
    size_t name_len = strlen(name);
    if (strncmp(line, name, name_len) != 0) {
        return NULL;
    }
    const char* p = line + name_len;
    SKIP_WS(p);
    if (*p != '=') {
        return NULL;
    }
    p++; // skip '='
    SKIP_WS(p);
    return p;
}

int* scan_int_list(const char** pptr, size_t* count) {
    const char* p = *pptr;
    int* list = NULL;
    while (true) {
        SKIP_WS(p);
        if (*p == '\0' || (!isdigit(*p) && *p != '-' && *p != '+')) {
            break;
        }

        int value = 0;
        int n = sscanf(p, "%d", &value);
        if (n != 1) {
            break;
        }

        list = xrealloc(list, (*count+1) * sizeof(int));
        list[*count] = value;
        (*count)++;

        // skip digits
        while (*p != '\0' && (isdigit(*p) || *p == '-' || *p == '+')) {
            p++;
        }

        // skip comma if present
        SKIP_WS(p);
        if (*p == ',') {
            p++;
        }
    }
    *pptr = p;
    return list;
}

Data* scan_data() {
    char line[BUFSIZ];

    Data* data = xcalloc(1, sizeof(Data));

    // read one line from stdin
    if (fgets(line, sizeof(line), stdin) == NULL) {
        fputs("Error reading input\n", stderr);
        free(data);
        return NULL; // EOF or error
    }

    // parse line
    const char* p = scan_name_equal(line, "matrix");
    if (p == NULL) {
        fputs("Invalid input format, waiting for matrix =\n", stderr);
        free(data);
        return NULL; // invalid format
    }

    // parse matrix
    do {
        size_t count = 0;
        int* row = scan_int_list(&p, &count);
        if (data->cols == 0) {
            data->cols = count;
        }
        else if (data->cols != count) {
            fputs("Inconsistent number of columns in matrix\n", stderr);
            free(row);
            free(data);
            return NULL;
        }
        data->matrix = xrealloc(data->matrix, (data->rows + 1) * sizeof(int*));
        data->matrix[data->rows] = row;
        data->rows++;

        if (fgets(line, sizeof(line), stdin) == NULL) {
            fputs("Error reading input\n", stderr);
            free_data(data);
            return NULL; // EOF or error
        }

        p = scan_name_equal(line, "k");
        if (p != NULL) {
            // parse k
            int n = sscanf(p, "%d", &data->k);
            if (n != 1) {
                fputs("Invalid format for k\n", stderr);
                free_data(data);
                return NULL;
            }
            break; // done reading matrix and k
        }

        p = line;
    } while (true);

    return data;
}

void print_matrix(int** matrix, size_t rows, size_t cols) {
    for (size_t i = 0; i < rows; i++) {
        for (size_t j = 0; j < cols; j++) {
            printf("%d,", matrix[i][j]);
            if (j + 1 != cols)
                printf(" ");
        }
        printf("\n");
    }
}

void print_data(const Data* data) {
    printf("k = %d\n", data->k);
    printf("Matrix (%zu x %zu):\n", data->rows, data->cols);
    print_matrix(data->matrix, data->rows, data->cols);
}

void shift_grid(int** matrix, size_t rows, size_t cols) {
    int last_elem = matrix[rows - 1][cols - 1];
    for (size_t i = rows * cols - 1; i > 0; i--) {
        size_t r = i / cols;
        size_t c = i % cols;
        size_t prev_r = (i - 1) / cols;
        size_t prev_c = (i - 1) % cols;
        matrix[r][c] = matrix[prev_r][prev_c];
    }
    matrix[0][0] = last_elem;
}

void shift_grid_k_times(int** matrix, size_t rows, size_t cols, int k) {
    size_t total_elements = rows * cols;
    k = k % total_elements; // optimize number of shifts
    for (size_t i = 0; i < k; i++) {
        shift_grid(matrix, rows, cols);
    }
}

int main() {
    Data* data = scan_data();
    if (data == NULL) {
        return EXIT_FAILURE; // error already reported
    }

    shift_grid_k_times(data->matrix, data->rows, data->cols, data->k);
    print_matrix(data->matrix, data->rows, data->cols);
    free_data(data);
}
