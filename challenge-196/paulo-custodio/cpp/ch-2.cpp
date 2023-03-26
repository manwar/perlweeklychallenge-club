/*
Challenge 197

Task 2: Range List
Submitted by: Mohammad S Anwar
You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range
all integers from x and y (both inclusive).


Each subsequence of two or more contiguous integers


Example 1
Input: @array = (1,3,4,5,7)
Output: [3,5]
Example 2
Input: @array = (1,2,3,6,7,9)
Output: [1,3], [6,7]
Example 3
Input: @array = (0,1,2,4,5,6,8,9)
Output: [0,2], [4,6], [8,9]
*/

#include <iostream>
#include <string>
#include <vector>

void print_ranges(const std::vector<int>& nums) {
    int nums_size=static_cast<int>(nums.size());
    std::cout<<"(";
    std::string sep="";
    for (int i=0; i<nums_size; i++) {
        int j=0;
        while (i+j<nums_size && nums[i]+j==nums[i+j])
            j++;
        if (j>1) {
            std::cout<<sep<<"["<<nums[i]<<","<<nums[i+j-1]<<"]";
            sep=", ";
            i+=j-1;
        }
    }
    std::cout<<")"<<std::endl;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr<<"usage: ch-1 nums..."<<std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    for (int i=0; i<argc; i++)
        nums.push_back(atoi(argv[i]));

    print_ranges(nums);
}
