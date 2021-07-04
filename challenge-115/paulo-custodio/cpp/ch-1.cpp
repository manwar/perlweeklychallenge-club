/*
Challenge 115

TASK #1 - String Chain
Submitted by: Mohammad S Anwar
You are given an array of strings.

Write a script to find out if the given strings can be chained to form a
circle. Print 1 if found otherwise 0.

A string $S can be put before another string $T in circle if the last
character of $S is same as first character of $T.

Examples:
Input: @S = ("abc", "dea", "cd")
Output: 1 as we can form circle e.g. "abc", "cd", "dea".

Input: @S = ("ade", "cbd", "fgh")
Output: 0 as we can't form circle.
*/

#include <iostream>
#include <list>
#include <string>
using namespace std;

bool is_chain(const string& word1, const string& word2) {
    if (word1.back() == word2.front())
        return true;
    else
        return false;
}

bool found_solution = false;

bool is_circle(list<string> pending, list<string> path) {
    if (found_solution) return true;
    if (pending.empty()) {
        if (!found_solution) found_solution = is_chain(path.back(), path.front());
    }
    else {
        for (auto& word : pending) {
            if (!found_solution) {
                if (path.empty() || is_chain(path.back(), word)) {
                    list<string> new_pending{ pending };
                    new_pending.remove(word);
                    list<string> new_path{ path };
                    new_path.push_back(word);

                    if (!found_solution) found_solution = is_circle(new_pending, new_path);
                }
            }
        }
    }
    return found_solution;
}

int main(int argc, char* argv[]) {
    list<string> words;
    for (int i = 1; i < argc; i++)
        words.push_back(argv[i]);
    bool found = is_circle(words, list<string>{});
    cout << (found ? 1 : 0) << endl;
}
