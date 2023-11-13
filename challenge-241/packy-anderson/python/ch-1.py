#!/usr/bin/env python

def findTriplets(diff, nums):
    count = 0
    details = ''
    for i in range(0, len(nums) - 2):
        for j in range(i + 1, len(nums) - 1):
            if not nums[j] - nums[i] == diff:
                continue
            for k in range(j + 1, len(nums)):
                if not nums[k] - nums[j] == diff:
                    continue
                count += 1
                details += (
                    f"({i}, {j}, {k}) is an arithmetic " +
                    f"triplet because both " +
                    f"{nums[k]} - {nums[j]} = {diff} and " +
                    f"{nums[j]} - {nums[i]} = {diff}\n"
                )
    return count, details

def solution(diff, nums):
    as_list = ', '.join(map(lambda i: str(i), nums))
    print(f'Input: @nums = ({as_list})')
    print(f'       $diff = {diff}')
    (count, details) = findTriplets(diff, nums)
    print(f'Output: {count}\n\n{details}')

print('Example 1:')
solution(3, [0, 1, 4, 6, 7, 10])

print('\nExample 2:')
solution(2, [4, 5, 6, 7, 8, 9])