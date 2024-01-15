// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <algorithm>  // transform
#include <iostream>   // cout
#include <limits>     // numeric_limits
#include <sstream>    // stringstream
#include <vector>

int fun(std::vector<std::vector<int>> const& matrix) {
    std::size_t n_rows = matrix.size(), n_cols = matrix[0].size();
    std::vector<int> row_minimals, col_maximals;
    row_minimals.reserve(n_rows);
    col_maximals.reserve(n_cols);

    // Row minimals
    std::transform(matrix.cbegin(), matrix.cend(),
                   std::back_inserter(row_minimals),
                   [] (std::vector<int> const& row) {
                       return *std::min_element(row.cbegin(), row.cend()); });

    // Column maximals
    for (std::size_t i{0}; i != n_cols; ++i) {
        int col_maximal{std::numeric_limits<int>::min()};
        for (auto row: matrix) {
            if (row[i] > col_maximal) {
                col_maximal = row[i];
            }
        }
        col_maximals.push_back(col_maximal);
    }

    // Set intersection...
    std::sort(row_minimals.begin(), row_minimals.end());
    std::sort(col_maximals.begin(), col_maximals.end());
    std::vector<int> intersections;
    std::set_intersection(row_minimals.cbegin(), row_minimals.cend(),
                          col_maximals.cbegin(), col_maximals.cend(),
                          std::back_inserter(intersections));

    return intersections.empty()
             ? -1
             : intersections[0];
}

int main(void) {
    // Tests
    std::vector<std::pair<std::vector<std::vector<int>>, int>> tests = {
        {{{3, 7, 8}, {9, 11, 13}, {15, 16, 17}}, 15},
        {{{1, 10, 4, 2}, {9, 3, 8, 7}, {15, 16, 17, 12}}, 12},
        {{{7, 8}, {1, 2}}, 7},
        {{{7, 8}, {13, 2}}, -1}
    };

    for (const auto& [input, expected_output] : tests) {
        int got = fun(input);
        if (got != expected_output) {
            std::stringstream error_msg;
            error_msg << "Expected " << expected_output << ", got " << got;
            throw std::runtime_error(error_msg.str());
        }
    }

    std::cout << "done-testing, success\n";
}
