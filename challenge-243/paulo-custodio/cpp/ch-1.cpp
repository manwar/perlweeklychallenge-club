/*
Challenge 243

Task 1: Reverse Pairs
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
nums[i] > 2 * nums[j].
Example 1

Input: @nums = (1, 3, 2, 3, 1)
Output: 2

(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2

Input: @nums = (2, 4, 3, 5, 1)
Output: 3

(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
*/

#include <iostream>
#include <vector>
using namespace std;

int num_reverse_pairs(const vector<int>& nums) {
    int count = 0;
    for (size_t i = 0; i < nums.size()-1; i++) {
        for (size_t j = i+1; j < nums.size(); j++) {
            if (nums[i] > 2 * nums[j])
                count++;
        }
    }
    return count;
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

    int count = num_reverse_pairs(nums);
    cout << count << endl;
}
