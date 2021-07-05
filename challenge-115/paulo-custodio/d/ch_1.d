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

import std.stdio;
import std.algorithm.mutation : remove;

bool is_chain(string word1, string word2) {
    if (word1[$-1] == word2[0])
        return true;
    else
        return false;
}

bool found_solution = false;

bool is_circle(string[] pending, string[] path) {
    if (found_solution) return true;
    if (pending.length == 0) {
        if (!found_solution) found_solution = is_chain(path[$-1], path[0]);
    }
    else {
        foreach (string word; pending) {
            if (!found_solution) {
                if (path.length == 0 || is_chain(path[$-1], word)) {
                    string[] new_pending = pending;
                    new_pending = remove!(a => a == word)(new_pending);
                    string[] new_path = path;
                    new_path ~= word;

                    if (!found_solution) found_solution = is_circle(new_pending, new_path);
                }
            }
        }
    }
    return found_solution;
}

void main(string[] args) {
    bool found = is_circle(args[1..$], []);
    writeln(found ? 1 : 0);
}
