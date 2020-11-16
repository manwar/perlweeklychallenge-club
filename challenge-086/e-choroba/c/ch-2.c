#include <stdio.h>

/*
  Direct translation of the Perl code. Solves Arto Inkala's hardest
  Sudoku 66 times faster on my machine.
*/

int maybe (int s[9][9], int y, int x, int try) {
    for (int i = 0; i < 9; ++i) {
        if (s[y][i] == try || s[i][x] == try) return 0;
    }
    int xs = x / 3;
    int ys = y / 3;
    for (int y1 = ys * 3; y1 <= ys * 3 + 2; ++y1) {
        for (int x1 = xs * 3; x1 <= xs * 3 + 2; ++x1) {
            if (s[y1][x1] == try) return 0;
        }
    }
    return 1;
}

int solve (int s[9][9]) {
    for (int x = 0; x < 9; ++x) {
        for (int y = 0; y < 9; ++y) {
            if (s[y][x]) continue;

            for (int try = 1; try <= 9; ++try) {
                if (maybe(s, y, x, try)) {
                    s[y][x] = try;
                    if (solve(s)) return 1;
                }
            }
            s[y][x] = 0;
            return 0;
        }
    }
    return 1;
}

void show(int s[9][9]) {
    for (int y = 0; y < 9; ++y) {
        for (int x = 0; x < 9; ++x) {
            printf(" %d", s[y][x]);
        }
        printf("\n");
    }
}

int main() {
    int s[9][9] = {
        0, 0, 0, 2, 6, 0, 7, 0, 1, 
        6, 8, 0, 0, 7, 0, 0, 9, 0, 
        1, 9, 0, 0, 0, 4, 5, 0, 0, 
        8, 2, 0, 1, 0, 0, 0, 4, 0, 
        0, 0, 4, 6, 0, 2, 9, 0, 0, 
        0, 5, 0, 0, 0, 3, 0, 2, 8, 
        0, 0, 9, 3, 0, 0, 0, 7, 4, 
        0, 4, 0, 0, 5, 0, 0, 3, 6, 
        7, 0, 3, 0, 1, 8, 0, 0, 0 };
    solve(s);
    show(s);
    return 0;
}
