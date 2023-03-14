/*
Challenge 207

Task 1: Keyboard Word
Submitted by: Mohammad S Anwar

You are given an array of words.

Write a script to print all the words in the given array that can be types
using alphabet on only one row of the keyboard.

Let us assume the keys are arranged as below:

Row 1: qwertyuiop
Row 2: asdfghjkl
Row 3: zxcvbnm

Example 1

Input: @words = ("Hello","Alaska","Dad","Peace")
Output: ("Alaska","Dad")

Example 2

Input: @array = ("OMG","Bye")
Output: ()
*/

#include <algorithm>
#include <cctype>
#include <iostream>
#include <string>

void remove_char(std::string& word, int ch) {
    word.erase(std::remove(word.begin(), word.end(), tolower(ch)), word.end());
}

bool can_type_word(const std::string& keys, const std::string& word_) {
    std::string word;
    for (auto& ch : word_)
        word.push_back(tolower(ch));
    for (auto& ch : keys)
        remove_char(word, tolower(ch));
    return word.size() == 0;
}

bool can_type(const std::string& word) {
    return can_type_word("qwertyuiop", word) ||
           can_type_word("asdfghjkl", word) ||
           can_type_word("zxcvbnm", word);
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    for (int i = 0; i < argc; i++)
        if (can_type(argv[i]))
            std::cout << argv[i];
    std::cout << std::endl;
}
