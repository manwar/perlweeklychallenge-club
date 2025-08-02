// g++ -Wall -Wextra -Wpedantic -std=c++17 cpp/ch-2.cpp
#include <algorithm>  // copy_if, reverse, transfomr
#include <iostream>
#include <sstream>    // form the error message
#include <vector>

static constexpr double TOLERANCE = 1E-6;

bool is_vowel(char c) { c = std::tolower(c); return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'; }

std::string fun(const std::string_view str) {
    std::vector<char> vowels;
    std::copy_if(str.cbegin(), str.cend(), std::back_inserter(vowels), is_vowel);
    std::reverse(vowels.begin(), vowels.end());

    std::string new_str(str.size(), '\0');
    auto vow_it = vowels.begin();
    std::transform(str.cbegin(), str.cend(),
                   new_str.begin(), [&vow_it](char c) {
                       return
                           is_vowel(c)
                             ? ('A' < c) && (c < 'Z')
                               ? std::toupper(*vow_it++)
                               : std::tolower(*vow_it++)
                             : c;
                   });

    return new_str;
}

int main() {
    // Tests
    std::vector<std::pair<std::string_view, std::string_view>> tests = {
        {"Raku", "Ruka"},
        {"Perl", "Perl"},
        {"Julia", "Jaliu"},
        {"Uiua", "Auiu"},
    };

    for (const auto& [input, expected_output] : tests) {
        auto got = fun(input);
        if (got != expected_output) {
            std::stringstream error_msg;
            error_msg << "Expected " << expected_output << ", got " << got;
            throw std::runtime_error(error_msg.str());
        }
    }

    std::cout << "done-testing, success\n";

}
