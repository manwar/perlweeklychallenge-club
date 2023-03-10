/*
Challenge 202

Task 1: Consecutive Odds
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to print 1 if there are THREE consecutive odds in the given array
otherwise print 0.

Example 1

Input: @array = (1,5,3,6)
Output: 1

Example 2

Input: @array = (2,6,3,5)
Output: 0

Example 3

Input: @array = (1,2,3,4)
Output: 0

Example 4

Input: @array = (2,3,5,7)
Output: 1
*/

#include <iostream>
#include <vector>

bool is_odd(int n) {
    return n%2==1;
}

int three_consecutive_odds(std::vector<int> nums) {
    for (int i = 0; i < static_cast<int>(nums.size()) - 2; i++)
        if (is_odd(nums[i]) && is_odd(nums[i+1]) && is_odd(nums[i+2]))
            return 1;
    return 0;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 2) {
        std::cerr << "Usage: ch-1 nums..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    std::cout << three_consecutive_odds(nums) << std::endl;

    return EXIT_SUCCESS;
}
