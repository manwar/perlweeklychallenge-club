/*
Challenge 098

TASK #2 › Search Insert Position
Submitted by: Mohammad S Anwar
You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found
otherwise place the target in the sorted array and return the index.

Example 1:
Input: @N = (1, 2, 3, 4) and $N = 3
Output: 2 since the target 3 is in the array at the index 2.
Example 2:
Input: @N = (1, 3, 5, 7) and $N = 6
Output: 3 since the target 6 is missing and should be placed at
the index 3.
Example 3:
Input: @N = (12, 14, 16, 18) and $N = 10
Output: 0 since the target 10 is missing and should be placed at
the index 0.
Example 4:
Input: @N = (11, 13, 15, 17) and $N = 19
Output: 4 since the target 19 is missing and should be placed at
the index 4.
*/

#include <algorithm>
#include <iostream>
#include <vector>

int search_index(std::vector<int>& nums, int n) {
    auto it = std::lower_bound(nums.begin(), nums.end(), n);
    if (it == nums.end()) {             // not found
        nums.push_back(n);
        return nums.size() - 1;
    }
    else if (*it != n) {                // found an higher value
        int index = std::distance(nums.begin(), it);    // insert may move memory
        nums.insert(it, n);
        return index;
    }
    else {                              // found value
        return std::distance(nums.begin(), it);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: ch-2 N n0 n1 n2..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> nums;
    int n = atoi(argv[1]);
    for (int i = 2; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    int pos = search_index(nums, n);

    std::cout << pos << std::endl;

    const char* sep = "(";
    for (auto& i : nums) {
        std::cout << sep << i;
        sep = ", ";
    }
    std::cout << ")" << std::endl;
}
