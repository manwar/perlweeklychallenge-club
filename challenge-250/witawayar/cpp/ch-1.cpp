// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <iostream>
#include <sstream>
#include <vector>

int fun(std::vector<int> ints) {
    for (size_t i = 0; i < ints.size(); ++i) {
        if ((int) i % 10 == ints[i])
            return i;
    }
    return -1;
}

int main(void) {
    std::vector<std::pair<std::vector<int>, int>> tests = {
        {{0, 1, 2}, 0},
        {{4, 3, 2, 1}, 2},
        {{1, 2, 3, 4, 5, 6, 7, 8, 9, 0}, -1}
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
