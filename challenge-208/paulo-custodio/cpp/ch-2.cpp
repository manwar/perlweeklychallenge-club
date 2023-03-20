/*
Challenge 208

Task 2: Duplicate and Missing
Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one duplicate.

Write a script to find the duplicate and missing integer in the given array.
Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one
duplicate and missing.

Example 1:

Input: @nums = (1,2,2,4)
Output: (2,3)

Duplicate is 2 and Missing is 3.

Example 2:

Input: @nums = (1,2,3,4)
Output: -1

No duplicate and missing found.

Example 3:

Input: @nums = (1,2,3,3)
Output: (3,4)

Duplicate is 3 and Missing is 4.
*/

#include <iostream>
#include <vector>

int count_nums(const std::vector<int>& nums, int n) {
    int count = 0;
    for (size_t i = 0; i < nums.size(); i++)
        if (nums[i] == n)
            count++;
    return count;
}

void print_dups_missing(const std::vector<int>& nums) {
    bool found = false;
    // find dups
    for (size_t i = 1; i <= nums.size(); i++) {
        if (count_nums(nums, i) > 1) {
            std::cout << i << " ";
            found = true;
        }
    }
    // find missing
    for (size_t i = 1; i <= nums.size(); i++) {
        if (count_nums(nums, i) == 0) {
            std::cout << i << " ";
            found = true;
        }
    }

    if (!found)
        std::cout << -1;
    std::cout << std::endl;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-2 nums..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    print_dups_missing(nums);
}
