/*
Challenge 243

Task 2: Floor Sum
Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where
0 <= i,j < nums.length. The floor() function returns the integer part of the
division.

Example 1

Input: @nums = (2, 5, 9)
Output: 10

floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1

Example 2

Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49
*/

#include <iostream>
#include <vector>
using namespace std;

int sum_floor(const vector<int>& nums) {
    int sum = 0;
    for (size_t i = 0; i < nums.size(); i++) {
        for (size_t j = 0; j < nums.size(); j++) {
            sum += nums[i] / nums[j];
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        cerr << "Usage: ch-1 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> nums;

    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        nums.push_back(n);
    }

    int sum = sum_floor(nums);
    cout << sum << endl;
}
