/*
Challenge 245

Task 2: Largest of Three
Submitted by: Mohammad S Anwar

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of
the given integers in any order which is also multiple of 3. Return -1 if
none found.

Example 1

Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2

Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3

Input: @ints = (1)
Output: -1
*/

#include <iostream>
#include <vector>
using namespace std;

int calc_largest(int prefix, const vector<int>& nums) {
    int largest = -1;

    // check current prefix
    if (prefix != 0 && prefix % 3 == 0 && prefix > largest)
        largest = prefix;

    // check all compinations of each number in nums
    vector<int> remain;
    for (size_t i = 0; i < nums.size(); i++) {
        // create list of numbers excluding n
        int n = nums[i];
        remain = nums;
        remain.erase(remain.begin() + i);

        int this_largest = calc_largest(prefix * 10 + n, remain);
        if (this_largest > largest)
            largest = this_largest;
    }

    return largest;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-2 n n n..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> nums;
    for (int i = 1; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    int largest = calc_largest(0, nums);
    cout << largest << endl;
}
