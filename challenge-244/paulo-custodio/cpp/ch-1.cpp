// Perl Weekly Challenge 244 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

#include <iostream>
#include <vector>
using namespace std;

vector<int> calc_smaller(const vector<int>& nums) {
    vector<int> smaller;

    for (size_t i = 0; i < nums.size(); i++) {
        int count = 0;
        for (size_t j = 0; j < nums.size(); j++) {
            if (nums[j] < nums[i])
                count++;
        }
        smaller.push_back(count);
    }
    return smaller;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-1 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> nums;
    for (int i = 1; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    vector<int> smaller = calc_smaller(nums);

    for (size_t i = 0; i < smaller.size(); i++)
        cout << smaller[i] << " ";
    cout << endl;
}
