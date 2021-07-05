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

#include <cassert>
#include <iostream>
#include <string>
using namespace std;

bool found_solution = false;

void print_sequences(int prev, const string& seq, const string& rest) {
    if (rest.empty()) {         // consumed all rest
        if (!found_solution) {  // only first solution printed
            cout << seq << endl;
            found_solution = true;
        }
    }
    else {
        for (int i = 1; !found_solution && i <= static_cast<int>(rest.size()); i++) {
            string prefix = rest.substr(0, i);
            string suffix = rest.substr(i);
            int new_prev = atoi(prefix.c_str());

            if (suffix[0] != '0') {
                if (prev < 0) {     // first time
                    string new_seq = prefix;
                    if (!found_solution)
                        print_sequences(new_prev, new_seq, suffix);
                }
                else {
                    if (prev + 1 == new_prev) {
                        string new_seq = seq + "," + prefix;
                        if (!found_solution)
                            print_sequences(new_prev, new_seq, suffix);
                    }
                }
            }
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    print_sequences(-1, "", argv[1]);
}
