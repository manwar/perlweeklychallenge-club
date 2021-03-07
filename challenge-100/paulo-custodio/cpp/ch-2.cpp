/*
Challenge 100

TASK #2 > Triangle Sum
Submitted by: Mohammad S Anwar
You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index i on the current row then you may move to either
index i or index i + 1 on the next row.

Example 1:
Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
Output: 8

Explanation: The given triangle

            1
           2 4
          6 4 9
         5 1 7 2

The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

             [1]
           [2]  4
           6 [4] 9
          5 [1] 7 2
Example 2:
Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
Output: 7

Explanation: The given triangle

            3
           3 1
          5 2 3
         4 3 1 3

The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

             [3]
            3  [1]
           5 [2] 3
          4 3 [1] 3
*/

#include <iostream>
#include <vector>
#include <cassert>
#include <cctype>

#define MIN(a,b)    ((a)<(b)?(a):(b))

// triangle (stored as a square)
class Triangle {
public:
    bool parse(int argc, char* argv[]) {
        for (int row = 0; row < argc; row++) {
            add_row();
            if (!parse_row(row, argv[row]))
                return false;
        }
        return true;
    }

    int min_sum() {
        return min_sum_1(0, 0, 0);
    }

private:
    std::vector<std::vector<int>> m_data;

    void add_row() {
        int rows = static_cast<int>(m_data.size()) + 1;
        m_data.resize(rows);
        for (int i = 0; i < rows; i++)
            m_data[i].resize(rows);
    }

    bool parse_row(int row, const char* text) {
        int rows = static_cast<int>(m_data.size());
        assert(row >= 0 && row < rows);
        for (int i = 0; i < rows; i++) {
            while (*text && !isdigit(*text)) text++;
            if (!isdigit(*text))
                return false;
            m_data[row][i] = atoi(text);
            while (*text && isdigit(*text)) text++;
        }
        return true;
    }

    int min_sum_1(int sum, int row, int col) {
        sum += m_data[row][col];
        int rows = static_cast<int>(m_data.size());
        if (row + 1 == rows)
            return sum;
        else {
            int sum1 = min_sum_1(sum, row + 1, col);
            int sum2 = min_sum_1(sum, row + 1, col + 1);
            return MIN(sum1, sum2);
        }
    }
};

int main(int argc, char* argv[]) {
    if (argc == 1) {
        fputs("Usage: ch-2 row row ...", stderr);
        return EXIT_FAILURE;
    }
    argc--; argv++;
    Triangle triangle;
    if (!triangle.parse(argc, argv)) {
        fputs("Malformed triangle", stderr);
        return EXIT_FAILURE;
    }
    int sum = triangle.min_sum();
    std::cout << sum << std::endl;
}
