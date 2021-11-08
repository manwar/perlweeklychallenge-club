/*
Challenge 118

TASK #1 - Binary Palindrome
Submitted by : Mohammad S Anwar
You are given a positive integer $N.

Write a script to find out if the binary representation of the given integer
is Palindrome.Print 1 if it is otherwise 0.

Example
Input: $N = 5
Output : 1 as binary representation of 5 is 101 which is Palindrome.

Input : $N = 4
Output : 0 as binary representation of 4 is 100 which is NOT Palindrome.
*/

import std.stdio;
import std.conv;
import std.algorithm.mutation;

string int_to_binary(int n) {
    string bin;
    while (n > 0) {
        bin = (n & 1 ? "1" : "0") ~ bin;
        n >>= 1;
    }
    return bin;
}

bool is_palindrome(int n) {
    string n_str = int_to_binary(n);
    string rev_n_str = n_str.dup.reverse;
    if (n_str == rev_n_str)
        return true;
    else
        return false;
}

void main(string[] args) {
    auto n = to!int(args[1]);
    writeln(is_palindrome(n) ? 1 : 0);
}
