// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <algorithm>  // transform
#include <iostream>   // cout
#include <numeric>    // accumulate
#include <sstream>    // stringstream
#include <vector>

int fun(std::vector<int> const& ints) {
    std::vector<int> out;
    std::transform(ints.cbegin(), ints.cend(),
                   ints.crbegin(), std::back_inserter(out),
                   [](const int& a, const int& b) {
                       return std::stoi(std::to_string(a) + std::to_string(b)); });
    std::size_t out_size = out.size();
    int sum = std::accumulate(out.cbegin(), out.cbegin() + out_size / 2, 0);
    if (out_size % 2 != 0)
        sum += ints[ints.size() / 2];

    return sum;
}

int main(void) {
    // Tests
    std::vector<std::pair<std::vector<int>, int>> tests = {
        {{6, 12, 25, 1}, 1286},
        {{10, 7, 31, 5, 2, 2}, 489},
        {{1, 2, 10}, 112}
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
