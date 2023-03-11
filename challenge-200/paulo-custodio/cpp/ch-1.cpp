/*
Challenge 200

Task 1: Arithmetic Slices
Submitted by: Mohammad S Anwar
You are given an array of integers.

Write a script to find out all Arithmetic Slices for the given array of integers.

An integer array is called arithmetic if it has at least 3 elements and the
differences between any three consecutive elements are the same.


Example 1
Input: @array = (1,2,3,4)
Output: (1,2,3), (2,3,4), (1,2,3,4)
Example 2
Input: @array = (2)
Output: () as no slice found.
*/

#include <iostream>
#include <vector>

bool is_arithmetic(int nums[], int nums_size) {
    if (nums_size < 3)
        return false;
    int step = nums[1] - nums[0];
    for (int i = 2; i < nums_size; i++) {
        if (nums[i] - nums[i-1] != step)
            return false;
    }
    return true;
}

void print_slices(std::vector<int> nums) {
    const char* sep = "";
    int nums_size = static_cast<int>(nums.size());

    std::cout << "(";
    for (int i = 0; i < nums_size-2; i++) {
        for (int j = i+2; j < nums_size; j++) {
            if (is_arithmetic(&nums[i], j-i+1)) {
                std::cout << sep;
                sep = "), (";
                for (int k = i; k <= j; k++) {
                    std::cout << nums[k];
                    if (k != j)
                        std::cout << ",";
                }
            }
        }
    }
    std::cout << ")" << std::endl;
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
    print_slices(nums);
}
