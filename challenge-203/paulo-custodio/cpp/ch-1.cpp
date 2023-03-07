/*
Challenge 203

Task 1: Special Quadruplets
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the total special quadruplets for the given array.

Special Quadruplets are such that satisfies the following 2 rules.
1) nums[a] + nums[b] + nums[c] == nums[d]
2) a < b < c < d


Example 1

Input: @nums = (1,2,3,6)
Output: 1

Since the only special quadruplets found is
$nums[0] + $nums[1] + $nums[2] == $nums[3].

Example 2

Input: @nums = (1,1,1,3,5)
Output: 4

$nums[0] + $nums[1] + $nums[2] == $nums[3]
$nums[0] + $nums[1] + $nums[3] == $nums[4]
$nums[0] + $nums[2] + $nums[3] == $nums[4]
$nums[1] + $nums[2] + $nums[3] == $nums[4]

Example 3

Input: @nums = (3,3,6,4,5)
Output: 0
*/

#include <iostream>
#include <vector>

int num_quadruplets(const std::vector<int>& nums) {
    int count = 0;
    if (nums.size() >= 4)
        for (size_t a = 0; a < nums.size() - 3; a++)
            for (size_t b = a + 1; b < nums.size() - 2; b++)
                for (size_t c = b + 1; c < nums.size() - 1; c++)
                    for (size_t d = c + 1; d < nums.size(); d++)
                        if (nums[a]+nums[b]+nums[c]==nums[d])
                            count++;
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));
    std:: cout << num_quadruplets(nums) << std::endl;
}
