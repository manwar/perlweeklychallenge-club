/*
Challenge 201

Task 1: Missing Numbers
Submitted by: Mohammad S Anwar

You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n
is the array size.

Example 1

Input: @array = (0,1,3)
Output: 2

The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.

Example 2

Input: @array = (0,1)
Output: 2

The array size is 2, therefore the range is 0..2.
The missing number is 2.
*/

#include <algorithm>
#include <iostream>
#include <vector>

void print_missing(std::vector<int>& nums) {
    std::sort(nums.begin(), nums.end());
    for (size_t i = 0; i <= nums.size(); i++) {     // check 0..N
        if (!std::binary_search(nums.begin(), nums.end(), i))
            std::cout << i << " ";
    }
    std::cout << std::endl;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-1 nums..." << std::endl;
        exit(EXIT_FAILURE);
    }

    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));
    print_missing(nums);
}
