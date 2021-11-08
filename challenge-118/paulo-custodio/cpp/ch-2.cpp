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

#include <cassert>
#include <cctype>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

#define NROWS       8
#define NCOLS       8
#define MAX_MOVES   8

struct Board {
    Board() {
        clear();
    }

    void clear() {
        memset(cells, 0, NROWS);
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

    char cells[NROWS];
};

struct Game {
    Game() {
        clear();
    }

    void clear() {
        row = col = 0;
        visited.clear();
        treasure.clear();
        path.clear();
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
        path += 'a' + col;
        path += to_string(NROWS - row);
        path += " ";
        this->row = row;
        this->col = col;
    }

    friend ostream& operator<<(ostream& os, const Game& game) {
        os << "  a b c d e f g h" << endl;
        for (int row = 0; row < NROWS; row++) {
            os << NROWS - row;
            for (int col = 0; col < NCOLS; col++) {
                if (game.peek_treasure(row, col))
                    os << " x";
                else if (game.row == row && game.col == col)
                    os << " N";
                else if (game.peek_visited(row, col))
                    os << " .";
                else
                    os << " *";
            }
            os << " " << NROWS - row << endl;
        }
        os << "  a b c d e f g h" << endl;
        os << endl << "> " << game.path << endl;
        return os;
    }

    void parse_header() {
        string line;
        if (!getline(cin, line)) {
            cerr << "expected header or footer" << endl;
            exit(EXIT_FAILURE);
        }
        const char* p = line.c_str();
        while (*p && isspace(*p)) p++;
        if (strncmp(p, "a b c d e f g h", 15) != 0) {
            cerr << "invalid header or footer" << endl;
            exit(EXIT_FAILURE);
        }
    }

    void parse_row(int row) {
        string line;
        if (!getline(cin, line)) {
            cerr << "expected row " << NROWS - row << endl;
            exit(EXIT_FAILURE);
        }
        const char* p = line.c_str();
        while (*p && isspace(*p)) p++;
        if (!isdigit(*p) || *p - '0' != NROWS - row) {
            cerr << "invalid row " << NROWS - row << endl;
            exit(EXIT_FAILURE);
        }
        p++;
        for (int col = 0; col < NCOLS; col++) {
            while (*p && isspace(*p)) p++;
            switch (*p) {
                case 'N': move(row, col); break;
                case 'x': set_treasure(row, col); break;
                case '*': break;
                default:
                    cerr << "invalid row " << NROWS - row << endl;
                    exit(EXIT_FAILURE);
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

    int row{ 0 }, col{ 0 };
    Board visited, treasure;
    string path;
};

struct Move {
    int row, col, num_moves;

    Move(int row = 0, int col = 0, int num_moves = 0)
        : row(row), col(col), num_moves(num_moves) {}
};

void try_move(vector<Move>& moves, Game& game, int nrow, int ncol) {
    if (nrow < 0 || nrow >= NROWS) return;
    if (ncol < 0 || ncol >= NCOLS) return;
    if (game.peek_visited(nrow, ncol)) return;

    moves.push_back(Move(nrow, ncol, 0));
}

void try_num_moves(vector<Move>& moves, Game& game, int row, int col) {
    moves.clear();
    try_move(moves, game, row + 2, col + 1);
    try_move(moves, game, row + 2, col - 1);
    try_move(moves, game, row - 2, col + 1);
    try_move(moves, game, row - 2, col - 1);
    try_move(moves, game, row + 1, col + 2);
    try_move(moves, game, row - 1, col + 2);
    try_move(moves, game, row + 1, col - 2);
    try_move(moves, game, row - 1, col - 2);
}

vector<Move> next_moves(Game& game) {
    vector<Move> moves;

    // try first step
    try_num_moves(moves, game, game.row, game.col);

    // for each target location count number of further steps
    int min_moves = MAX_MOVES + 1;
    for (size_t i = 0; i < moves.size(); i++) {
        vector<Move> temp_moves;
        try_num_moves(temp_moves, game, moves[i].row, moves[i].col);
        moves[i].num_moves = temp_moves.size();
        if (min_moves > moves[i].num_moves) min_moves = moves[i].num_moves;
    }

    // remove all moves with targets > min_moves
    size_t j = 0;
    for (size_t i = 0; i < moves.size(); i++) {
        if (moves[i].num_moves == min_moves)
            moves[j++] = moves[i];
    }
    moves.resize(j);

    return moves;
}

void solve(Game& solution, Game& game) {
    if (game.done()) {
        if (solution.path.size() == 0 || solution.path.size() > game.path.size()) {
            // cout << game;
            solution = game;
        }
    }
    else {
        vector<Move> moves = next_moves(game);
        for (size_t i = 0; i < moves.size(); i++) {
            Game new_game = game;
            new_game.move(moves[i].row, moves[i].col);
            solve(solution, new_game);
        }
    }
}

int main(void) {
    Game game, solution;
    game.parse();

    solve(solution, game);
    cout << solution.path << endl;
}
