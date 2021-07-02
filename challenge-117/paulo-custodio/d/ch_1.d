/*
Challenge 117

TASK #1 - Missing Row
Submitted by: Mohammad S Anwar
You are given text file with rows numbered 1-15 in random order but there is a
catch one row in missing in the file.

11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five

Write a script to find the missing row number.
*/

import std.stdio;
import std.conv;
import std.array;

enum NUM_LINES = 15;

void main() {
    bool[NUM_LINES] found = false;

    string line;
    while ((line = readln()) !is null) {
        int n = to!int(line.split(",")[0]);
        if (n >= 1 && n <= NUM_LINES)
            found[n - 1] = true;
    }

    string separator = "";
    for (int n = 1; n <= NUM_LINES; n++) {
        if (!found[n - 1]) {
            write(separator, n);
            separator = ", ";
        }
    }
    writeln("");
}
