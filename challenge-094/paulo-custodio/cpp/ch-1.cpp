/*
Challenge 094

TASK #1 › Group Anagrams
Submitted by: Mohammad S Anwar
You are given an array of strings @S.

Write a script to group Anagrams together in any random order.

An Anagram is a word or phrase formed by rearranging the letters of a
different word or phrase, typically using all the original letters exactly
once.

Example 1:
    Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
    Output: [ ("bat", "tab"),
              ("saw", "was"),
              ("top", "pot", "opt") ]
Example 2:
    Input: ("x")
    Output: [ ("x") ]
*/

#include <algorithm>
#include <iostream>
#include <list>
#include <map>
#include <string>

std::string make_key(const std::string& str) {
    std::string out{ str };
    std::sort(out.begin(), out.end());
    return out;
}

int main(int argc, char* argv[]) {
    std::map<std::string, std::list<std::string>> map;      // maps keys to lists of words

    for (int i = 1; i < argc; i++) {
        auto key = make_key(argv[i]);
        auto found = map.find(key);
        if (found == map.end()) {           // not found, create new item
            std::list<std::string> list;
            list.push_back(argv[i]);
            map[key] = list;
        }
        else {                              // append to existing item
            found->second.push_back(argv[i]);
        }
    }

    std::cout << "[ ";
    bool first1 = true;
    for (auto& it1 : map) {
        if (!first1)
            std::cout << "," << std::endl << "  ";
        first1 = false;

        std::cout << "(";
        bool first2 = true;
        for (auto& it2 : it1.second) {
            if (!first2)
                std::cout << ", ";
            first2 = false;

            std::cout << "\"" << it2 << "\"";
        }
        std::cout << ")";
    }
    std::cout << " ]" << std::endl;
}
