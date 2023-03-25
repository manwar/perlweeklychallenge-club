/*
Challenge 197

Task 1: Move Zero
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to move all zero, if exists, to the end while maintaining
the relative order of non-zero elements.


Example 1
Input:  @list = (1, 0, 3, 0, 0, 5)
Output: (1, 3, 5, 0, 0, 0)
Example 2
Input: @list = (1, 6, 4)
Output: (1, 6, 4)
Example 3
Input: @list = (0, 1, 0, 2, 0)
Output: (1, 2, 0, 0, 0)
*/

#include <iostream>
#include <vector>

void move_zeros(std::vector<int>& nums) {
    std::vector<int> copy=nums;
    size_t p=0;
    for (size_t i=0; i<copy.size(); i++)
        if (copy[i]!=0)
            nums[p++]=copy[i];
    for (size_t i=0; i<copy.size(); i++)
        if (copy[i]==0)
            nums[p++]=copy[i];
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-1 nums..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i=0; i<argc; i++)
        nums.push_back(atoi(argv[i]));

    move_zeros(nums);

    for (int i=0; i<argc; i++)
        std::cout << nums[i] << " ";
    std::cout << std::endl;
}
