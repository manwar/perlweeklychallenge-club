import std.stdio;

void main() {
    enum MAX = 10;
    int tr[MAX][MAX];
    tr[0][0] = 1;
    int results[MAX] = 1;
    for (int row = 1; row < MAX; row++) {
        tr[row][0] = tr[row - 1][row - 1];
        results[row] = tr[row][0];
        for (int i = 1; i <= row; i++) {
            tr[row][i] = tr[row][i-1] + tr[row - 1][i-1];
        }
    }
    writeln("The first 10 Bell numbers are: ", results);
}
