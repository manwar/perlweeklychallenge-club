/*
Challenge 244

Task 1: Count Smaller
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer
at each index.
Example 1

Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.

Example 2

Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

Example 3

Input: @int = (2, 2, 2)
Output: (0, 0, 0)
*/

#include <iostream>
#include <vector>
using namespace std;

vector<int> calc_smaller(const vector<int>& nums) {
    vector<int> smaller;

    for (size_t i = 0; i < nums.size(); i++) {
        int count = 0;
        for (size_t j = 0; j < nums.size(); j++) {
            if (nums[j] < nums[i])
                count++;
        }
        smaller.push_back(count);
    }
    return smaller;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-1 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> nums;
    for (int i = 1; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    vector<int> smaller = calc_smaller(nums);

    for (size_t i = 0; i < smaller.size(); i++)
        cout << smaller[i] << " ";
    cout << endl;
}
