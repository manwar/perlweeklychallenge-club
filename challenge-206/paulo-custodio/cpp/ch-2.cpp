/*
Challenge 206

Task 2: Array Pairings
Submitted by: Mohammad S Anwar

You are given an array of integers having even number of elements..

Write a script to find the maximum sum of the minimum of each pairs.
Example 1

Input: @array = (1,2,3,4)
Output: 4

Possible Pairings are as below:
a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3

So the maxium sum is 4.

Example 2

Input: @array = (0,2,1,3)
Output: 2

Possible Pairings are as below:
a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1

So the maximum sum is 2.
*/

#include <algorithm>
#include <iostream>
#include <vector>

void compute_pairs_max(int& max,
    const std::vector<int>& set, const std::vector<int>& pending
) {
    if (pending.size() == 0) {      // compute sum, set max
        int sum = 0;
        for (size_t i = 0; i < set.size(); i += 2) {
            int n = std::min(set[i], set[i + 1]);
            sum += n;
        }
        max = std::max(max, sum);
    }
    else {                          // recurse for each pair
        for (size_t i = 0; i < pending.size() - 1; i++) {
            for (size_t j = i+1; j < pending.size(); j++) {
                std::vector<int> new_set = set;
                std::vector<int> new_pending = pending;

                new_set.push_back(pending[i]);
                new_set.push_back(pending[j]);

                new_pending.erase(new_pending.begin() + j);
                new_pending.erase(new_pending.begin() + i);

                compute_pairs_max(max, new_set, new_pending);
            }
        }
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc % 2 != 0) {
        std::cerr << "usage: ch-2 pairs..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<int> set;
    std::vector<int> pending;
    for (int i = 0; i < argc; i++)
        pending.push_back(atoi(argv[i]));

    int max = 0;
    compute_pairs_max(max, set, pending);
    std::cout << max << std::endl;

    return EXIT_SUCCESS;
}
