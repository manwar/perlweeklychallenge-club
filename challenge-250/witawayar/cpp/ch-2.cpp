// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-2.cpp
#include <iostream>
#include <sstream>
#include <vector>

int fun(std::vector<std::string> alpha_num_strs) {
    int max = -1;
    for (const std::string& str : alpha_num_strs) {
        int current =
            str.find_first_not_of("0123456789") == std::string::npos
              ? std::stoi(str)
              : str.size();
        if (current > max) {
            max = current;
        }
    }
    return max;
}

int main(void) {
    std::vector<std::pair<std::vector<std::string>, int>> tests = {
        {{"perl", "2", "000", "python", "r4ku"}, 6},
        {{"001", "1", "000", "0001"}, 1},
        {{"-12", "2"}, 3}
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
