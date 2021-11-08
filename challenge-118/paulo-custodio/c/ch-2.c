/*
Challenge 118

TASK #2 - Adventure of Knight
Submitted by : Cheok - Yin Fung
A knight is restricted to move on an 8×8 chessboard.The knight is denoted by
N and its way of movement is the same as what it is defined in Chess.
* represents an empty square. x represents a square with treasure.

The Knight’s movement is unique.It may move two squares vertically and one
square horizontally, or two squares horizontally and one square vertically
(with both forming the shape of an L).

There are 6 squares with treasures.

Write a script to find the path such that Knight can capture all treasures.
The Knight can start from the top - left square.

      a b c d e f g h
    8 N * * * * * * * 8
    7 * * * * * * * * 7
    6 * * * * x * * * 6
    5 * * * * * * * * 5
    4 * * x * * * * * 4
    3 * x * * * * * * 3
    2 x x * * * * * * 2
    1 * x * * * * * * 1
      a b c d e f g h

https://en.m.wikipedia.org/wiki/Knight%27s_tour
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>
#include <ctype.h>

#define NROWS       8
#define NCOLS       8
#define BOARD_SIZE  (NROWS*NCOLS)
#define PATH_SIZE   ((BOARD_SIZE*3)+1)
#define MAXLINE     1024
#define MAX_MOVES   8

void die(const char* fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    exit(EXIT_FAILURE);
}

typedef struct Board {
    char cells[NROWS];
} Board;

void board_clear(Board* board) {
    memset(board->cells, 0, NROWS);
}

bool board_empty(Board* board) {
    for (int i = 0; i < NROWS; i++)
        if (board->cells[i] != 0)
            return false;
    return true;
}

void board_set(Board* board, int row, int col) {
    assert(row >= 0 && row < NROWS);
    assert(col >= 0 && col < NCOLS);
    int mask = 1 << col;
    board->cells[row] |= mask;
}

void board_reset(Board* board, int row, int col) {
    assert(row >= 0 && row < NROWS);
    assert(col >= 0 && col < NCOLS);
    int mask = 1 << col;
    board->cells[row] &= ~mask;
}

bool board_peek(Board* board, int row, int col) {
    assert(row >= 0 && row < NROWS);
    assert(col >= 0 && col < NCOLS);
    int mask = 1 << col;
    return (board->cells[row] & mask) == 0 ? false : true;
}


typedef struct Game {
    int row, col;
    Board visited, treasure;
    char path[PATH_SIZE];
} Game;

void game_clear(Game* game) {
    memset(game, 0, sizeof(Game));
}

void game_set_visited(Game* game, int row, int col) {
    board_set(&game->visited, row, col);
}

bool game_peek_visited(Game* game, int row, int col) {
    return board_peek(&game->visited, row, col);
}

bool game_peek_treasure(Game* game, int row, int col) {
    return board_peek(&game->treasure, row, col);
}

void game_set_treasure(Game* game, int row, int col) {
    board_set(&game->treasure, row, col);
}

void game_clear_treasure(Game* game, int row, int col) {
    board_reset(&game->treasure, row, col);
}

bool game_done(Game* game) {
    return board_empty(&game->treasure);
}

void game_move(Game* game, int row, int col) {
    game_set_visited(game, row, col);
    game_clear_treasure(game, row, col);
    sprintf(game->path + strlen(game->path), "%c%d ", 'a' + col, NROWS - row);
    game->row = row;
    game->col = col;
}

void game_print(Game* game) {
    printf("  a b c d e f g h\n");
    for (int row = 0; row < NROWS; row++) {
        printf("%d", NROWS - row);
        for (int col = 0; col < NCOLS; col++) {
            if (game_peek_treasure(game, row, col))
                printf(" x");
            else if (game->row == row && game->col == col)
                printf(" N");
            else if (game_peek_visited(game, row, col))
                printf(" .");
            else
                printf(" *");
        }
        printf(" %d\n", NROWS - row);
    }
    printf("  a b c d e f g h\n");
    printf("\n> %s\n\n", game->path);
}

void game_parse_header(void) {
    char line[MAXLINE];

    if (!fgets(line, MAXLINE, stdin))
        die("expected header or footer\n");
    const char* p = line;
    while (*p && isspace(*p)) p++;
    if (strncmp(p, "a b c d e f g h", 15) != 0)
        die("invalid header or footer\n");
}

void game_parse_row(Game* game, int row) {
    char line[MAXLINE];

    if (!fgets(line, MAXLINE, stdin))
        die("expected row %d\n", NROWS - row);

    const char* p = line;
    while (*p && isspace(*p)) p++;
    if (!isdigit(*p) || *p - '0' != NROWS - row)
        die("invalid row %d\n", NROWS - row);
    p++;
    for (int col = 0; col < NCOLS; col++) {
        while (*p && isspace(*p)) p++;
        switch (*p) {
        case 'N': game_move(game, row, col); break;
        case 'x': game_set_treasure(game, row, col); break;
        case '*': break;
        default: die("invalid row %d\n", NROWS - row);
        }
        p++;
    }
}

void game_parse(Game* game) {
    game_clear(game);
    game_parse_header();
    for (int row = 0; row < NROWS; row++)
        game_parse_row(game, row);
    game_parse_header();
}


typedef struct Move {
    int row, col, num_moves;
} Move;

void try_move(int* num_moves, Move* moves, Game* game, int nrow, int ncol) {
    if (nrow < 0 || nrow >= NROWS) return;
    if (ncol < 0 || ncol >= NCOLS) return;
    if (game_peek_visited(game, nrow, ncol)) return;

    moves[*num_moves].row = nrow;
    moves[*num_moves].col = ncol;
    moves[*num_moves].num_moves = 0;
    (*num_moves)++;
}

void try_num_moves(int* num_moves, Move* moves, Game* game, int row, int col) {
    *num_moves = 0;
    try_move(num_moves, moves, game, row + 2, col + 1);
    try_move(num_moves, moves, game, row + 2, col - 1);
    try_move(num_moves, moves, game, row - 2, col + 1);
    try_move(num_moves, moves, game, row - 2, col - 1);
    try_move(num_moves, moves, game, row + 1, col + 2);
    try_move(num_moves, moves, game, row - 1, col + 2);
    try_move(num_moves, moves, game, row + 1, col - 2);
    try_move(num_moves, moves, game, row - 1, col - 2);
}

int next_moves(Move* moves, Game* game) {
    // try first step
    int num_moves = 0;
    try_num_moves(&num_moves, moves, game, game->row, game->col);

    // for each target location count number of further steps
    int min_moves = MAX_MOVES + 1;
    for (int i = 0; i < num_moves; i++) {
        Move temp_moves[MAX_MOVES];
        try_num_moves(&moves[i].num_moves, temp_moves, game, moves[i].row, moves[i].col);
        if (min_moves > moves[i].num_moves) min_moves = moves[i].num_moves;
    }

    // remove all moves with targets > min_moves
    int j = 0;
    for (int i = 0; i < num_moves; i++) {
        if (moves[i].num_moves == min_moves)
            moves[j++] = moves[i];
    }
    num_moves = j;

    return num_moves;
}

void solve(Game* solution, Game* game) {
    if (game_done(game)) {
        if (strlen(solution->path) == 0 ||
            strlen(solution->path) > strlen(game->path)) {
//          game_print(game);
            *solution = *game;
        }
    }
    else {
        Move moves[MAX_MOVES];
        int num_moves = next_moves(moves, game);
        for (int i = 0; i < num_moves; i++) {
            Game new_game = *game;
            game_move(&new_game, moves[i].row, moves[i].col);
            solve(solution, &new_game);
        }
    }
}

int main(void) {
    Game game, solution;
    game_clear(&game);
    game_clear(&solution);

    game_parse(&game);
    solve(&solution, &game);
    printf("%s\n", solution.path);
}
