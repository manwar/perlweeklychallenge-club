/*
Challenge 197

Task 2: Wiggle Sort
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.


Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….


Example 1
Input: @list = (1,5,1,1,6,4)
Output: (1,6,1,5,1,4)
Example 2
Input: @list = (1,3,2,2,3,1)
Output: (2,3,1,3,1,2)
*/

#include <algorithm>
#include <iostream>
#include <vector>

void copy_data(std::vector<int>& to, int to_idx, const std::vector<int>& from, int from_idx) {
    for (; to_idx>=0; to_idx-=2)
        to[to_idx]=from[from_idx++];
}

void wiggle_sort(std::vector<int>& nums) {
    int nums_size=static_cast<int>(nums.size());
    std::vector<int> copy=nums;
    std::sort(copy.begin(), copy.end());
    copy_data(nums, nums_size-2, copy, 0);
    copy_data(nums, nums_size-1, copy, nums_size/2);
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-2 nums..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i=0; i<argc; i++)
        nums.push_back(atoi(argv[i]));

    wiggle_sort(nums);

    for (int i=0; i<argc; i++)
        std::cout << nums[i] << " ";
    std::cout << std::endl;
}
