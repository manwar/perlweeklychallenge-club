// Perl Weekly Challenge 243 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

#include <iostream>
#include <vector>

int sum_floor(const std::vector<int>& nums) {
    int sum = 0;
    for (size_t i = 0; i < nums.size(); i++) {
        for (size_t j = 0; j < nums.size(); j++) {
            sum += nums[i] / nums[j];
        }
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        std::cerr << "Usage: ch-1 n n n ..." << std::endl;
        exit(EXIT_FAILURE);
    }

    std::vector<int> nums;

    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        nums.push_back(n);
    }

    int sum = sum_floor(nums);
    std::cout << sum << std::endl;
}
