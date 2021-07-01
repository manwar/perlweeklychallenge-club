/*
Challenge 118

TASK #2 - Adventure of Knight
Submitted by : Cheok - Yin Fung
A knight is restricted to move on an 8x8 chessboard.The knight is denoted by
N and its way of movement is the same as what it is defined in Chess.
* represents an empty square. x represents a square with treasure.

The Knight's movement is unique.It may move two squares vertically and one
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

import std.stdio;
import std.conv;
import core.stdc.stdlib : exit;

enum NROWS     = 8;
enum NCOLS     = 8;
enum MAX_MOVES = 8;

struct Board {
    ubyte[NROWS] cells;

    void clear() {
        cells[] = 0;
    }

    bool empty() const {
        for (int i = 0; i < NROWS; i++)
            if (cells[i] != 0)
                return false;
        return true;
    }

    void set(int row, int col) {
        assert(row >= 0 && row < NROWS);
        assert(col >= 0 && col < NCOLS);
        int mask = 1 << col;
        cells[row] |= mask;
    }

    void reset(int row, int col) {
        assert(row >= 0 && row < NROWS);
        assert(col >= 0 && col < NCOLS);
        int mask = 1 << col;
        cells[row] &= ~mask;
    }

    bool peek(int row, int col) const {
        assert(row >= 0 && row < NROWS);
        assert(col >= 0 && col < NCOLS);
        int mask = 1 << col;
        return (cells[row] & mask) == 0 ? false : true;
    }
}

struct Game {
    int row, col;
    Board visited, treasure;
    string path;

    void clear() {
        row = col = 0;
        visited.clear();
        treasure.clear();
        path = "";
    }

    void set_visited(int row, int col) {
        visited.set(row, col);
    }

    bool peek_visited(int row, int col) const {
        return visited.peek(row, col);
    }

    void set_treasure(int row, int col) {
        treasure.set(row, col);
    }

    void clear_treasure(int row, int col) {
        treasure.reset(row, col);
    }

    bool peek_treasure(int row, int col) const {
        return treasure.peek(row, col);
    }

    bool done() const {
        return treasure.empty();
    }

    void move(int row, int col) {
        set_visited(row, col);
        clear_treasure(row, col);
        path ~= 'a' + col;
        path ~= to!string(NROWS - row);
        path ~= " ";
        this.row = row;
        this.col = col;
    }

    void print() {
        writeln("  a b c d e f g h");
        for (int row = 0; row < NROWS; row++) {
            write(NROWS - row);
            for (int col = 0; col < NCOLS; col++) {
                if (peek_treasure(row, col))
                    write(" x");
                else if (this.row == row && this.col == col)
                    write(" N");
                else if (peek_visited(row, col))
                    write(" .");
                else
                    write(" *");
            }
            writeln(" ", NROWS - row);
        }
        writeln("  a b c d e f g h");
        writeln("");
        writeln("> ", path);
    }

    void parse_header() {
        string line;
        if ((line = readln()) is null) {
            stderr.writeln("expected header or footer");
            exit(1);
        }
        auto p = 0;
        while (p < line.length && line[p] == ' ') p++;
        if (line[p .. p+15] != "a b c d e f g h") {
            stderr.writeln("invalid header or footer");
            exit(1);
        }
    }

    void parse_row(int row) {
        string line;
        if ((line = readln()) is null) {
            stderr.writeln("expected row ", NROWS - row);
            exit(1);
        }
        auto p = 0;
        while (p < line.length && line[p] == ' ') p++;
        if (line[p] - '0' != NROWS - row) {
            stderr.writeln("invalid row ", NROWS - row);
            exit(1);
        }
        p++;
        for (int col = 0; col < NCOLS; col++) {
            while (p < line.length && line[p] == ' ') p++;
            switch (line[p]) {
                case 'N': move(row, col); break;
                case 'x': set_treasure(row, col); break;
                case '*': break;
                default:
                    stderr.writeln("invalid row ", NROWS - row);
                    exit(1);
            }
            p++;
        }
    }

    void parse() {
        clear();
        parse_header();
        for (int row = 0; row < NROWS; row++)
            parse_row(row);
        parse_header();
    }

}

struct Move {
    int row, col, num_moves;
}

void try_move(Move[]* moves, Game* game, int nrow, int ncol) {
    if (nrow < 0 || nrow >= NROWS) return;
    if (ncol < 0 || ncol >= NCOLS) return;
    if (game.peek_visited(nrow, ncol)) return;

    *moves = *moves ~ [Move(nrow, ncol, 0)];
}

void try_num_moves(Move[]* moves, Game* game, int row, int col) {
    *moves = [];
    try_move(moves, game, row + 2, col + 1);
    try_move(moves, game, row + 2, col - 1);
    try_move(moves, game, row - 2, col + 1);
    try_move(moves, game, row - 2, col - 1);
    try_move(moves, game, row + 1, col + 2);
    try_move(moves, game, row - 1, col + 2);
    try_move(moves, game, row + 1, col - 2);
    try_move(moves, game, row - 1, col - 2);
}

Move[] next_moves(Game* game) {
    Move[] moves;

    // try first step
    try_num_moves(&moves, game, game.row, game.col);

    // for each target location count number of further steps
    int min_moves = MAX_MOVES + 1;
    for (int i = 0; i < moves.length; i++) {
        Move[] temp_moves;
        try_num_moves(&temp_moves, game, moves[i].row, moves[i].col);
        moves[i].num_moves = temp_moves.length;
        if (min_moves > moves[i].num_moves) min_moves = moves[i].num_moves;
    }

    // remove all moves with targets > min_moves
    int j = 0;
    for (int i = 0; i < moves.length; i++) {
        if (moves[i].num_moves == min_moves)
            moves[j++] = moves[i];
    }
    moves = moves[0 .. j];

    return moves;
}

void solve(Game* solution, Game* game) {
    if (game.done()) {
        if (solution.path.length == 0 ||
            solution.path.length > game.path.length) {
                //game.print();
                *solution = *game;
            }
    }
    else {
        Move[] moves = next_moves(game);
        for (int i = 0; i < moves.length; i++) {
            Game new_game = *game;
            new_game.move(moves[i].row, moves[i].col);
            solve(solution, &new_game);
        }
    }
}

void main() {
    Game game, solution;
    game.parse();

    solve(&solution, &game);
    writeln(solution.path);
}
