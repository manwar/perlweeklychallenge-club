/*
Challenge 116

TASK #1 - Number Sequence
Submitted by: Mohammad S Anwar
You are given a number $N >= 10.

Write a script to split the given number such that the difference between two
consecutive numbers is always 1 and it shouldn't have leading 0.

Print the given number if it impossible to split the number.

Example
Input: $N = 1234
Output: 1,2,3,4

Input: $N = 91011
Output: 9,10,11

Input: $N = 10203
Output: 10203 as it is impossible to split satisfying the conditions.
*/

import std.stdio;
import std.conv;

bool found_solution = false;

void print_sequences(int prev, string seq, string rest) {
    if (rest == "") {           // consumed all rest
        if (!found_solution) {  // only first solution printed
            writeln(seq);
            found_solution = true;
        }
    }
    else {
        for (int i = 1; !found_solution && i <= rest.length; i++) {
            string prefix = rest[0 .. i];
            string suffix = rest[i .. $];
            int new_prev = to!int(prefix);
            char suffix_begin = (suffix == "") ? 0 : suffix[0];
            if (suffix_begin != '0') {
                if (prev < 0) {     // first time
                    string new_seq = prefix;
                    if (!found_solution)
                        print_sequences(new_prev, new_seq, suffix);
                }
                else {
                    if (prev + 1 == new_prev) {
                        string new_seq = seq ~ "," ~ prefix;
                        if (!found_solution)
                            print_sequences(new_prev, new_seq, suffix);
                    }
                }
            }
        }
    }
}

void main(string[] args) {
    print_sequences(-1, "", args[1]);
}
