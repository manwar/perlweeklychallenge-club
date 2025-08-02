// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-2.cpp
#include <algorithm>  // transform
#include <iostream>   // cout
#include <numeric>    // accumulate
#include <sstream>    // stringstream
#include <tuple>      // tie
#include <vector>

std::vector<int> fun(std::vector<std::vector<int>> const& matrix) {
    std::vector<std::pair<int, std::vector<int>>> aug_matrix;
    for (std::size_t idx{0}; idx < matrix.size(); ++idx) {
        aug_matrix.emplace_back(idx, matrix[idx]);
    }
    std::sort(aug_matrix.begin(), aug_matrix.end(),
              [](auto& vec_a, auto& vec_b) {
                  auto a_sum = std::accumulate(vec_a.second.cbegin(), vec_a.second.cend(), 0);
                  auto b_sum = std::accumulate(vec_b.second.cbegin(), vec_b.second.cend(), 0);
                  return std::tie(a_sum, vec_a.first) < std::tie(b_sum, vec_b.first);
              });
    std::vector<int> sorter_indexes;
    std::transform(aug_matrix.cbegin(), aug_matrix.cend(),
                   std::back_inserter(sorter_indexes),
                   [](auto& pair) { return pair.first; });
    return sorter_indexes;
}

int main(void) {
    // Tests
    std::vector<std::pair<std::vector<std::vector<int>>, std::vector<int>>> tests = {
        {
            {
                {1, 1, 0, 0, 0},
                    {1, 1, 1, 1, 0},
                    {1, 0, 0, 0, 0},
                    {1, 1, 0, 0, 0},
                    {1, 1, 1, 1, 1}
            }, {2, 0, 3, 1, 4}},
        {
            {
                {1, 0, 0, 0},
                {1, 1, 1, 1},
                {1, 0, 0, 0},
                {1, 0, 0, 0}
            }, {0, 2, 3, 1}}
    };

    std::size_t test_case{0};
    for (const auto& [input, expected_output] : tests) {
        auto got = fun(input);
        if (got != expected_output) {
            std::stringstream error_msg;
            error_msg << "Failed at " << test_case++ << "th test case";
            throw std::runtime_error(error_msg.str());
        }
    }

    std::cout << "done-testing, success\n";
}
