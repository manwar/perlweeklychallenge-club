/*
Challenge 197

Task 1: Pattern 132
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.


Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].


Example 1
Input:  @list = (3, 1, 4, 2)
Output: (1, 4, 2) respect the Pattern 132.
Example 2
Input: @list = (1, 2, 3, 4)
Output: () since no susbsequence can be found.
Example 3
Input: @list = (1, 3, 2, 4, 6, 5)
Output: (1, 3, 2) if more than one subsequence found then return the first.
Example 4
Input: @list = (1, 3, 4, 2)
Output: (1, 3, 2)
*/

#include <iostream>
#include <vector>

void print_patter132(const std::vector<int>& nums) {
    int nums_size=static_cast<int>(nums.size());
    std::cout<<"(";
    for (int i=0; i<nums_size-2; i++) {
        for (int j=i+1; j<nums_size-1; j++) {
            for (int k=j+1; k<nums_size; k++) {
                if (nums[i]<nums[k] && nums[k]<nums[j]) {
                    std::cout<<nums[i]<<" "<<nums[j]<<" "<<nums[k];
                    goto end;
                }
            }
        }
    }
end:
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

    print_patter132(nums);
}
