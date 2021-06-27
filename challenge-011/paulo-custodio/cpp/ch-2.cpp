/*
Challenge 011

Challenge #2
Write a script to create an Indentity Matrix for the given size. For example,
if the size is 4, then create Identity Matrix 4x4. For more information about
Indentity Matrix, please read the wiki page.
*/

#include <iostream>
#include <vector>
using namespace std;

vector<vector<int>> identity_matrix(int n) {
    vector<vector<int>> id;
    for (int row = 0; row < n; row++) {
        id.push_back({});
        for (int col = 0; col < n; col++)
            id[row].push_back(col == row ? 1 : 0);
    }
    return id;
}

void print_matrix(ostream& os, vector<vector<int>>& m) {
    os << "[";
    const char* row_sep = "";
    for (size_t row = 0; row < m.size(); row++) {
        os << row_sep << "[";
        row_sep = ",\n ";
        const char* col_sep = "";
        for (size_t col = 0; col < m[row].size(); col++) {
            os << col_sep << m[row][col];
            col_sep = ", ";
        }
        os << "]";
    }
    os << "]\n";
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2)
        n = atoi(argv[1]);
    if (n < 1)
        n = 4;

    vector<vector<int>> id = identity_matrix(n);
    print_matrix(cout, id);
}
