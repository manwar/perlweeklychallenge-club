// Perl Weekly Challenge 241 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-241/

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
