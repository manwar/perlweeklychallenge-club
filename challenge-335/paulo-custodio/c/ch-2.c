#include "alloc.h"

#define BOARD_SIZE  3
#define EMPTY       '_'
#define PLAYER1     'A'
#define PLAYER2     'B'
#define DRAW        'x'
#define PENDING     '?'

typedef struct {
    char cell[BOARD_SIZE][BOARD_SIZE];
} Board;

void init_board(Board* board) {
    for (int r = 0; r < BOARD_SIZE; r++) {
        for (int c = 0; c < BOARD_SIZE; c++) {
            board->cell[r][c] = EMPTY;
        }
    }
}

bool player_wins(Board* board, char player) {
    for (int r = 0; r < BOARD_SIZE; r++) {
        if (board->cell[r][0] == player &&
            board->cell[r][1] == player &&
            board->cell[r][2] == player)
            return true;
    }
    for (int c = 0; c < BOARD_SIZE; c++) {
        if (board->cell[0][c] == player &&
            board->cell[1][c] == player &&
            board->cell[2][c] == player)
            return true;
    }
    if (board->cell[0][0] == player &&
        board->cell[1][1] == player &&
        board->cell[2][2] == player)
        return true;
    if (board->cell[0][2] == player &&
        board->cell[1][1] == player &&
        board->cell[2][0] == player)
        return true;

    return false;
}

bool board_full(Board* board) {
    for (int r = 0; r < BOARD_SIZE; r++) {
        for (int c = 0; c < BOARD_SIZE; c++) {
            if (board->cell[r][c] == EMPTY)
                return false;
        }
    }

    return true;
}

char play_move(Board* board, char player, int r, int c) {
    if (board->cell[r][c] != EMPTY)
        die("invalid move (%d,%d), cell already occupied by '%c'",
                r, c, board->cell[r][c]);

    board->cell[r][c] = player;

    if (player_wins(board, player)) {
        return player;
    }

    if (board_full(board)) {
        return DRAW;
    }

    return PENDING;
}

void play_game() {
    Board board;
    char line[BUFSIZ];

    init_board(&board);
    char player = PLAYER1;
    int r = 0, c = 0;
    while (fgets(line, sizeof(line), stdin)) {
        if (sscanf(line, "%d %d", &r, &c) != 2) {
            continue;
        }

        if (r < 0 || r >= BOARD_SIZE || c < 0 || c >= BOARD_SIZE) {
            fprintf(stderr, "invalid coordinates (%d,%d)\n", r, c);
            continue;
        }

        char result = play_move(&board, player, r, c);
        if (result == player) {
            printf("%c\n", player); // won
            return;
        }
        else if (result == DRAW) {
            printf("Draw\n");
            return;
        }

        player = (player==PLAYER1) ? PLAYER2 : PLAYER1;
    }

    printf("Pending\n");
}

int main() {
    play_game();
}
