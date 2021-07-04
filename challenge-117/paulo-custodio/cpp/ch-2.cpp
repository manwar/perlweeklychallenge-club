/*
Challenge 117

TASK #2 - Find Possible Paths
Submitted by: E. Choroba
You are given size of a triangle.

Write a script to find all possible paths from top to the bottom right
corner.

In each step, we can either move horizontally to the right (H), or move
downwards to the left (L) or right (R).

BONUS: Try if it can handle triangle of size 10 or 20.

Example 1:
Input: $N = 2

           S
          / \
         / _ \
        /\   /\
       /__\ /__\ E

Output: RR, LHR, LHLH, LLHH, RLH, LRH
Example 2:
Input: $N = 1

           S
          / \
         / _ \ E

Output: R, LH
*/

#include <iostream>
#include <string>
using namespace std;

string separator = "";

void find_paths(int size, const string& path, int row, int col) {
    if (row == size && col == size) {   // reached end
        cout << separator << path;
        separator = ", ";
    }
    else {  // recurse
        if (row < size) {
            find_paths(size, path + "L", row + 1, col);
            find_paths(size, path + "R", row + 1, col + 1);
        }
        if (col < row) {
            find_paths(size, path + "H", row, col + 1);
        }
    }
}

int main(int argc, char* argv[]) {
    int size = 1;
    if (argc == 2) size = atoi(argv[1]);
    find_paths(size, "", 0, 0);
    cout << endl;
}
