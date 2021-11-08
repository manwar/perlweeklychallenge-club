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

#include <iostream>
#include <string>
using namespace std;

string int_to_binary(int n) {
    string bin;
    while (n > 0) {
        bin = string(n & 1 ? "1" : "0") + bin;
        n >>= 1;
    }
    return bin;
}

string reverse_string(const string& src) {
    string out;
    for (int i = static_cast<int>(src.size()) - 1; i >= 0; i--)
        out += src[i];
    return out;
}

bool is_palindrome(int n) {
    string n_str = int_to_binary(n);
    string rev_n_str = reverse_string(n_str);
    if (n_str == rev_n_str)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2) n = atoi(argv[1]);
    cout << (is_palindrome(n) ? 1 : 0) << endl;
}
