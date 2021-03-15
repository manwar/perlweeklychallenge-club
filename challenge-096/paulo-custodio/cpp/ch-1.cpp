/*
Challenge 096

TASK #1 › Reverse Words
Submitted by: Mohammad S Anwar
You are given a string $S.

Write a script to reverse the order of words in the given string. The string
may contain leading/trailing spaces. The string may have more than one space
between words in the string. Print the result without leading/trailing spaces
and there should be only one space between words.

Example 1:
Input: $S = "The Weekly Challenge"
Output: "Challenge Weekly The"
*/

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

int main(int argc, char* argv[]) {
    // concatenate all args
    std::string text;
    for (int i = 1; i < argc; i++) {
        text += argv[i];
        text += " ";
    }

    // build list of words
    std::vector<std::string> words;
    std::istringstream iss(text);
    std::string word;
    while (iss >> word)
        words.push_back(word);

    // print words in reverse order
    for (auto it = words.rbegin(); it != words.rend(); ++it)
        std::cout << *it << " ";
    std::cout << std::endl;
}
