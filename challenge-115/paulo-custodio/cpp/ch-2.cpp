/*
Challenge 115

TASK #2 - Largest Multiple
Submitted by: Mohammad S Anwar
You are given a list of positive integers (0-9), single digit.

Write a script to find the largest multiple of 2 that can be formed from the
list.

Examples
Input: @N = (1, 0, 2, 6)
Output: 6210

Input: @N = (1, 4, 2, 8)
Output: 8412

Input: @N = (4, 1, 7, 6)
Output: 7614
*/

#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

int reverse_cmp(const void* a, const void* b) {
    return -(*(int*)a - *(int*)b);
}

int largest_even(vector<int>& nums) {
    // smallest even number is last digit
    int last_digit = 10;
    for (size_t i = 0; i < nums.size(); i++) {
        if ((nums[i] % 2) == 0 && nums[i] < last_digit)
            last_digit = nums[i];
    }
    if (last_digit == 10) return 0;

    // remove last_digit from list
    nums.erase(remove(nums.begin(), nums.end(), last_digit), nums.end());

    // sort remaining digits in descending order
    sort(nums.begin(), nums.end(), std::greater<>());

    int result = 0;
    for (size_t i = 0; i < nums.size(); i++)
        result = result * 10 + nums[i];
    result = result * 10 + last_digit;

    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2) return EXIT_FAILURE;

    vector<int>nums;
    for (int i = 1; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    cout << largest_even(nums) << endl;
}
