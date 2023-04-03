/*
Challenge 194

Task 2: Frequency Equalizer
Submitted by: Mohammad S Anwar
You are given a string made of alphabetic characters only, a-z.

Write a script to determine whether removing only one character can make the
frequency of the remaining characters the same.

Example 1:
Input: $s = 'abbc'
Output: 1 since removing one alphabet 'b' will give us 'abc' where each
alphabet frequency is the same.
Example 2:
Input: $s = 'xyzyyxz'
Output: 1 since removing 'y' will give us 'xzyyxz'.
Example 3:
Input: $s = 'xzxz'
Output: 0 since removing any one alphabet would not give us string with same
frequency alphabet.
*/

#include <iostream>
#include <string>
#include <vector>
#include <cctype>

const int LETTERS = ('z'-'a'+1);

int freq_equalizer(const std::string& s) {
    std::vector<int> freq;
    freq.resize(LETTERS);

    if (s.empty()) return 0;
    for (auto& c : s) {
        if (isalpha(c))
            freq[tolower(c)-'a']++;
    }

    int min=0, max=0;
    for (auto& f : freq) {
        if (f) {
            if (min==0) min=max=f;
            if (min>f) min=f;
            if (max<f) max=f;
        }
    }

    if (min+1!=max) return 0;

    int count=0;
    for (auto& f : freq) {
        if (f==max) count++;
    }

    return count==1 ? 1 : 0;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        std::cerr << "usage: ch-1 string" << std::endl;
        return EXIT_FAILURE;
    }

    std::cout << freq_equalizer(argv[0]) << std::endl;
}
