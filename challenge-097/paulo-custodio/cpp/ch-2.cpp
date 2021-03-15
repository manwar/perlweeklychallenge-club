/*
Challenge 097

TASK #2 › Binary Substings
Submitted by: Mohammad S Anwar
You are given a binary string $B and an integer $S.

Write a script to split the binary string $B of size $S and then find the
minimum number of flips required to make it all the same.

Example 1:
Input: $B = “101100101”, $S = 3
Output: 1

Binary Substrings:
    "101": 0 flip
    "100": 1 flip to make it "101"
    "101": 0 flip
Example 2:
Input $B = “10110111”, $S = 4
Output: 2

Binary Substrings:
    "1011": 0 flip
    "0111": 2 flips to make it "1011"
*/

#include <iostream>
#include <string>

int str_flips(const char* a, const char* b, int n) {
    int flips = 0;
    for (int i = 0; i < n; i++) {
        if (a[i] != b[i])
            flips++;
    }
    return flips;
}

int bit_flips(const std::string& bits, int n) {
    int flips = 0;
    for (int i = n; i < static_cast<int>(bits.size()); i += n)
        flips += str_flips(bits.c_str(), bits.c_str()+i, n);
    return flips;
}

int main(int argc, char* argv[]) {
    if (argc == 3)
        std::cout << bit_flips(std::string(argv[1]), atoi(argv[2])) << std::endl;
}
