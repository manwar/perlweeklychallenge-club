// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <algorithm>  // transform
#include <iostream>   // cout
#include <numeric>    // accumulate
#include <sstream>    // stringstream
#include <vector>

int fun(std::vector<int> const& ints) {
    std::vector<int> out;
    const std::size_t N = ints.size();
    std::vector<std::size_t> indexes(N);
    std::iota(indexes.begin(), indexes.end(), 1u);
    std::transform(ints.cbegin(), ints.cend(),
                   indexes.cbegin(), std::back_inserter(out),
                   [&](const int& value, const std::size_t& index) {
                       return N % index == 0 ? value * value : 0; });

    return std::accumulate(out.cbegin(), out.cend(), 0);
}

int main(void) {
    // Tests
    std::vector<std::pair<std::vector<int>, int>> tests = {
        {{1, 2, 3, 4}, 21},
        {{2, 7, 1, 19, 18, 3}, 63},
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
