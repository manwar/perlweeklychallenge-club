#!/usr/bin/python3
def reverse_pairs(*nums: int) -> int:
    tally = 0
    for j in range(1, len(nums)):
        for i in range(0, j):
            if nums[i] > 2 * nums[j]:
                tally += 1
    return tally

assert reverse_pairs(1, 3, 2, 3, 1) == 2
assert reverse_pairs(2, 4, 3, 5, 1) == 3

