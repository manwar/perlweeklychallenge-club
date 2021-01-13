/*
    Task 2 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/

    Comments: https://andrewshitov.com/2020/09/08/lonely-x-the-weekly-challenge-77-task-2/

    Compile as:
    $ g++ -std=c++17 ch-2.cpp

    Output for the given example of matrix:
    $ ./a.out 
    0, 3
    1, 1
    2, 3


    If there Xs that have other Xs as their neighbours, then
    this program makes less cell checks than ch-2.cpp:

    $ g++ -std=c++17 ch-2.cpp
    bash-3.2$ ./a.out 
    0, 0
    2, 0
    35 checks made

    $ g++ -std=c++17 ch-2a.cpp
    $ ./a.out 
    0, 0
    2, 0
    30 checks made
*/

#include <iostream>
#include <vector>

using namespace std;

int test_move_calls = 0;
vector<int> test_move(vector<vector<char>> matrix, vector<int> current, vector<int> shift) {
    test_move_calls++;

    current[0] += shift[0];
    current[1] += shift[1];

    if (current[0] < 0 || current[0] >= matrix.size() ||
        current[1] < 0 || current[1] >= matrix[0].size()) {
            return vector<int>();
    }
    else {
        return current;
    }
}

int main() {
    vector<vector<char>> matrix = {
        {'X', 'O', 'O', 'X'},
        {'O', 'O', 'X', 'O'},
        {'X', 'O', 'O', 'X'}
    };

    vector<vector<int>> neighbours = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};

    for (auto row = 0; row != matrix.size(); row++) {
        for (auto col = 0; col != matrix[0].size(); col++) {
            if (matrix[row][col] != 'X') continue;

            bool ok = true;
            for (auto neighbour : neighbours) {
                auto move = test_move(matrix, vector<int>{row, col}, neighbour);
                if (move.empty()) continue;
                if (matrix[move[0]][move[1]] != 'O') {
                    matrix[move[0]][move[1]] = 'Y';
                    ok = false;
                    break;
                }
            }
            if (ok) cout << row << ", " << col << endl;
        }
    }

    cout << test_move_calls << " checks made" << endl;
}
