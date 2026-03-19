// Perl Weekly Challenge 243 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

#include <iostream>
#include <vector>

int num_reverse_pairs(const std::vector<int>& nums) {
    int count = 0;
    for (size_t i = 0; i < nums.size()-1; i++) {
        for (size_t j = i+1; j < nums.size(); j++) {
            if (nums[i] > 2 * nums[j])
                count++;
        }
    }
    return count;
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

    int count = num_reverse_pairs(nums);
    std::cout << count << std::endl;
}
