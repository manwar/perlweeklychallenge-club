/*
Challenge 199

Task 2: Good Triplets
Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following
conditions:

a) 0 <= i < j < k <= n (size of given array)
b) abs(array[i] - array[j]) <= x
c) abs(array[j] - array[k]) <= y
d) abs(array[i] - array[k]) <= z

Example 1

Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
Output: 4

Good Triplets are as below:
(3,0,1) where (i=0, j=1, k=2)
(3,0,1) where (i=0, j=1, k=3)
(3,1,1) where (i=0, j=2, k=3)
(0,1,1) where (i=1, j=2, k=3)

Example 2

Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
Output: 0
*/

#include <iostream>
#include <vector>


int count_good_triplets(std::vector<int> nums, int x, int y, int z) {
    int nums_size = static_cast<int>(nums.size());
    int count = 0;
    for (int i = 0; i < nums_size-2; i++) {
        for (int j = i+1; j < nums_size-1; j++) {
            for (int k = j+1; k < nums_size; k++) {
                if (abs(nums[i] - nums[j]) <= x &&
                    abs(nums[j] - nums[k]) <= y &&
                    abs(nums[i] - nums[k]) <= z)
                    count++;
            }
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 6) {
        std::cerr << "usage: ch-1 nums... x y z" << std::endl;
        return EXIT_FAILURE;
    }

    int z = atoi(argv[--argc]);
    int y = atoi(argv[--argc]);
    int x = atoi(argv[--argc]);
    std::vector<int> nums;
    for (int i = 0; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    std::cout << count_good_triplets(nums, x, y, z) << std::endl;
}
