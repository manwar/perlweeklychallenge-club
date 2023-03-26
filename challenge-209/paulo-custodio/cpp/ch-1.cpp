/*
Challenge 209

Task 1: Special Bit Characters
Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"

Write a script to print 1 if the last character is an “a” otherwise print 0.
Example 1

Input: @bits = (1, 0, 0)
Output: 1

The given array bits can be decoded as 2-bits character (10) followed by
1-bit character (0).

Example 2

Input: @bits = (1, 1, 1, 0)
Output: 0

Possible decode can be 2-bits character (11) followed by 2-bits character
(10) i.e. the last character is not 1-bit character.
*/

#include <iostream>
#include <string>

std::string decode(const std::string& in) {
    std::string out;
    const char* p = in.c_str();
    while (*p) {
        switch (*p) {
        case '0': out.push_back('a'); p++; break;
        case '1':
            p++;
            switch (*p) {
            case '0': out.push_back('b'); p++; break;
            case '1': out.push_back('c'); p++; break;
            default: std::cerr << "invalid input" << std::endl; exit(EXIT_FAILURE);
            }
            break;
        default: std::cerr << "invalid input" << std::endl; exit(EXIT_FAILURE);
        }
    }
    return out;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        std::cerr << "usage: ch-2 str" << std::endl;
        return EXIT_FAILURE;
    }

    std::string out = decode(argv[0]);
    int result = (!out.empty() && out.back()=='a') ? 1 : 0;
    std::cout << result << std::endl;
}
