// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-2.cpp
#include <iostream>   // cout
#include <numeric>    // accumulate
#include <sstream>    // stringstream
#include <vector>

std::vector<int> fun(int const& n) {
    std::vector<int> range(n);
    std::iota(range.begin(), range.end(), -(n / 2));
    return range;
}

int main(void) {
    // Tests
    std::vector<unsigned> tests{5, 3, 1};

    for (const unsigned& input : tests) {
        std::vector<int> got = fun(input);
        int sum = std::accumulate(got.cbegin(), got.cend(), 0);
        if (sum != 0) {
            std::stringstream error_msg;
            error_msg << "Expected " << 0 << ", got " << sum;
            throw std::runtime_error(error_msg.str());
        }
    }

    std::cout << "done-testing, success\n";
}
