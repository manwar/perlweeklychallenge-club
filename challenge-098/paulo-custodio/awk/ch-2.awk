#!/usr/bin/gawk

# Challenge 098
#
# TASK #2 > Search Insert Position
# Submitted by: Mohammad S Anwar
# You are given a sorted array of distinct integers @N and a target $N.
#
# Write a script to return the index of the given target if found
# otherwise place the target in the sorted array and return the index.
#
# Example 1:
# Input: @N = (1, 2, 3, 4) and $N = 3
# Output: 2 since the target 3 is in the array at the index 2.
# Example 2:
# Input: @N = (1, 3, 5, 7) and $N = 6
# Output: 3 since the target 6 is missing and should be placed at
# the index 3.
# Example 3:
# Input: @N = (12, 14, 16, 18) and $N = 10
# Output: 0 since the target 10 is missing and should be placed at
# the index 0.
# Example 4:
# Input: @N = (11, 13, 15, 17) and $N = 19
# Output: 4 since the target 19 is missing and should be placed at
# the index 4.

# print contents of array (nums, nums_size)
function print_array() {
    sep = "";
    printf "("
    for (i=0; i<nums_size; i++) {
        printf sep nums[i];
        sep = ", ";
    }
    print ")";
}

# insert an element in (nums, nums_size), shifting all other positions up
function insert(p, n) {
    nums_size++;
    for (i=nums_size-1; i>p; i--)
        nums[i] = nums[i-1];
    nums[p] = n;
}

# use bisect method to search for position
function search_insert(n) {
    if (nums_size == 0) {           # input empty
        nums[nums_size++] = n;
        return 0;
    }
    else if (n < nums[0]) {         # before first
        insert(0, n);
        return 0;
    }
    else if (n > nums[nums_size-1]) {# after last
        nums[nums_size++] = n;
        return nums_size-1;
    }
    else {                          # bisect
        bot = 0; top = nums_size;
        mid = int((top + bot) / 2);
        while (bot+1 < top) {
            if (n == nums[mid])
                return mid;
            else if (n < nums[mid])
                top = mid;
            else
                bot = mid;
            mid = int((top + bot) / 2)
        }

        # not found, insert at mid+1
        insert(mid+1, n);
        return mid+1;
    }
}

BEGIN {
    n = ARGV[1];
    nums_size = 0;       # nums[] size

    for (i = 2; i < ARGC; i++) {
        nums[nums_size++] = ARGV[i];
    }
    p = search_insert(n);
    print p;
    print_array();
    exit 0;
}
