// Perl Weekly Challenge 218 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-218/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int bin_to_dec(int* data, int size) {
    int result = 0;
    for (int i = 0; i < size; i++) {
        if (data[i])
            result = 2*result+1;
        else
            result = 2*result;
    }
    return result;
}

int compute_score(IntMatrix* game) {
    int score = 0;
    for (int r = 0; r < game->rows; r++) {
        score += bin_to_dec(game->data[r], game->cols);
    }
    return score;
}

void invert_row(IntMatrix* game, int row) {
    for (int c = 0; c < game->cols; c++)
        game->data[row][c] = !game->data[row][c];
}

void invert_col(IntMatrix* game, int col) {
    for (int r = 0; r < game->rows; r++)
        game->data[r][col] = !game->data[r][col];
}

int count_ones_in_col(IntMatrix* game, int col) {
    int count = 0;
    for (int r = 0; r < game->rows; r++) {
        if (game->data[r][col] == 1)
            count++;
    }
    return count;
}

int maximize_score(IntMatrix* game) {
    // flip rows where MSB is not 1
    for (int r = 0; r < game->rows; r++) {
        if (!game->data[r][0])
            invert_row(game, r);
    }

    // flip columns that have less 1s than 0s
    for (int c = 1; c < game->cols; c++) {
        int count = count_ones_in_col(game, c);
        if (2 * count < game->rows)
            invert_col(game, c);
    }

    return compute_score(game);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s row...", argv[0]);

    int rows = argc-1;
    int cols = strlen(argv[1]);
    IntMatrix* game = intmatrix_new(rows, cols);
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            game->data[r][c] = (argv[r+1][c] == '1') ? 1 : 0;
        }
    }

    int score = maximize_score(game);
    printf("%d\n", score);

    intmatrix_free(game);
}
