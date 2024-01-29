// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-1.cpp
#include <algorithm>  // remove_if
#include <iostream>   // cout
#include <sstream>    // stringstream
#include <vector>

std::vector<std::string> fun(std::vector<std::string> const& words, std::string separator) {
    std::vector<std::string> parts;
    std::size_t sep_size = separator.size();

    for (auto& sub_word : words) {
        std::size_t start = 0;
        for (size_t found = sub_word.find(separator);
             found != std::string::npos;
             found = sub_word.find(separator, start)) {
            parts.emplace_back(sub_word.begin() + start, sub_word.begin() + found);
            start = found + sep_size;
        }
        if (start != sub_word.size())
            parts.emplace_back(sub_word.begin() + start, sub_word.end());
    }
    parts.erase(std::remove_if(parts.begin(), parts.end(), [](std::string const& str) {
        return str.find_first_not_of(' ') == std::string::npos; }), parts.end());

    return parts;
}

int main(void) {
    // Tests
    std::vector<std::pair<std::pair<std::vector<std::string>, std::string>, std::vector<std::string>>> tests = {
        {{{"one.two.three", "four.five", "six"}, "."}, {"one", "two", "three", "four", "five", "six"}},
            {{{"$perl$$", "$$raku$"}, "$"}, {"perl", "raku"}}
    };

    for (const auto& [input, expected_output] : tests) {
        auto [words, separator] = input;
        auto got = fun(words, separator);
        if (got != expected_output) {
            std::stringstream error_msg;
            error_msg << "Failed at " << separator;
            throw std::runtime_error(error_msg.str());
        }
    }

    std::cout << "done-testing, success\n";
}
