/*
Challenge 199

Task 1: Good Pairs
Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total count of Good Pairs.

    A pair (i, j) is called good if list[i] == list[j] and i < j.


Example 1

Input: @list = (1,2,3,1,1,3)
Output: 4

There are 4 good pairs found as below:
(0,3)
(0,4)
(3,4)
(2,5)

Example 2

Input: @list = (1,2,3)
Output: 0

Example 3

Input: @list = (1,1,1,1)
Output: 6

Good pairs are below:
(0,1)
(0,2)
(0,3)
(1,2)
(1,3)
(2,3)
*/

#include <iostream>
#include <vector>

int count_good_pairs(std::vector<int> nums) {
    int nums_size = static_cast<int>(nums.size());
    int count = 0;
    for (int i = 0; i < nums_size-1; i++) {
        for (int j = i+1; j < nums_size; j++) {
            if (nums[i] == nums[j])
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-1 nums..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    std::cout << count_good_pairs(nums) << std::endl;
}
