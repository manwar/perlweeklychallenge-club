/*
Challenge 241

Task 1: Arithmetic Triplets
Submitted by: Mohammad S Anwar

You are given an array (3 or more members) of integers in increasing order
and a positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying
the following rules:

a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff

Example 1

Input: @nums = (0, 1, 4, 6, 7, 10)
       $diff = 3
Output: 2

Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.

Example 2

Input: @nums = (4, 5, 6, 7, 8, 9)
       $diff = 2
Output: 2

(0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
(1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.
*/

#include <iostream>
#include <string>
#include <vector>
using namespace std;

int count_triplets(vector<int>& nums, int diff) {
    int count = 0;
    for (int i = 0; i < static_cast<int>(nums.size()) - 2; i++) {
        for (int j = i + 1; j < static_cast<int>(nums.size()) - 1; j++) {
            for (int k = j + 1; k < static_cast<int>(nums.size()); k++) {
                if (nums[j] - nums[i] == diff && nums[k] - nums[j] == diff)
                    count++;
            }
        }
    }
    return count;
}

void usage(void) {
    cerr << "Usage: ch-1 -nums n n n ... -diff n" << endl;
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    vector<int> nums;
    int diff = -1;

    // parse args
    int i = 1;
    while (i < argc) {
        string arg = argv[i];
        if (arg == "-nums") {
            i++;
            while (i < argc && argv[i][0] != '-') {
                int n = atoi(argv[i]);
                nums.push_back(n);
                i++;
            }
        }
        else if (arg == "-diff") {
            i++;
            if (i < argc) {
                diff = atoi(argv[i]);
                i++;
            }
        }
        else {
            usage();
        }
    }
    if (nums.empty() || diff < 0)
        usage();

    // process
    int count = count_triplets(nums, diff);
    cout << count << endl;
}
