/*
Challenge 242

Task 2: Flip Matrix
Submitted by: Mohammad S Anwar
You are given n x n binary matrix.

Write a script to flip the given matrix as below.


1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
Example 2
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
*/

#include <algorithm>
#include <iostream>
#include <regex>
#include <string>
#include <vector>
using namespace std;

vector<string> regex_split(const string& s, const regex& sep_regex = regex{ "\\s+" }) {
    sregex_token_iterator iter(s.begin(), s.end(), sep_regex, -1);
    sregex_token_iterator end;
    return { iter, end };
}

vector<int> parse_list(const string& text) {
    vector<int> result;
    auto nums = regex_split(text, regex{ "[\\[\\](),; \\t]+" });
    for (auto& num : nums) {
        if (!num.empty()) {
            int n = stoi(num);
            result.push_back(n);
        }
    }
    return result;
}


vector<vector<int>> parse_matrix(const string& text) {
    vector<vector<int>> matrix;
    auto rows_text = regex_split(text, regex("\\],"));
    for (auto& row_text : rows_text) {
        auto row = parse_list(row_text);
        matrix.push_back(row);
    }
    return matrix;
}

void process_matrix(vector<vector<int>>& matrix) {
    for (auto& row : matrix) {
        // a) Reverse each row
        reverse(row.begin(), row.end());

        // b) Invert each member
        for (auto& n : row)
            n = 1 - n;
    }
}

void print_list(const vector<int>& arr) {
    cout << "[";
    string sep = "";
    for (auto& n : arr) {
        cout << sep << n;
        sep = ", ";
    }
    cout << "]";
}

void print_matrix(vector<vector<int>>& matrix) {
    cout << "(";
    string sep = "";
    for (auto& row : matrix) {
        cout << sep;
        print_list(row);
        sep = ", ";
    }
    cout << ")";
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Usage: ch-2 '([a, b, c], [d, e, f], [g, h, i])'" << endl;
        exit(EXIT_FAILURE);
    }

    auto matrix = parse_matrix(argv[1]);
    process_matrix(matrix);
    print_matrix(matrix);
#if 0
    free_matrix(matrix);

    utarray_free(matrix);
#endif
}
#if 0


void free_matrix(UT_array* matrix) {
    for (UT_array** p = NULL; (p = utarray_next(matrix, p)) != NULL; ) {
        utarray_free(*p);
        *p = NULL;
    }
}

#endif
