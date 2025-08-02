// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <cmath>     // abs, round, cbrt
#include <iostream>
#include <sstream>   // form the error message
#include <vector>

static constexpr double TOLERANCE = 1E-6;

bool fun(int n) {
    double cube_root = std::cbrt(n);
    return std::abs(cube_root - std::round(cube_root)) < TOLERANCE;
}

int main() {
    // Tests
    std::vector<std::pair<int, int>> tests = {
        {0, true},
        {1, true},
        {-343, true},
        {27, true},
        {122, false},
        {6, false},
        {777, false}
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
