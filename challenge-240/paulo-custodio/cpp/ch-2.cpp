/*
Challenge 240

Task 2: Build Array
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
Example 1

Input: @int = (0, 2, 1, 5, 3, 4)
Output: (0, 1, 2, 4, 5, 3)

Example 2

Input: @int = (5, 0, 1, 2, 3, 4)
Output: (4, 5, 0, 1, 2, 3)
*/

#include <iostream>
#include <vector>
using namespace std;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-2 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> olds;
    vector<int> news;

    // parse args
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        olds.push_back(n);
    }

    // process
    for (size_t i = 0; i < olds.size(); i++) {
        int n = olds[olds[i]];
        news.push_back(n);
    }

    // output
    const char* sep = "";
    for (size_t i = 0; i < news.size(); i++) {
        cout << sep << news[i];
        sep = " ";
    }
    cout << endl;
}
