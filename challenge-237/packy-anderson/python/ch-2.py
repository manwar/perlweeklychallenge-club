#!/usr/bin/env python

def greatness(nums, perm):
    """
    Function to enumerate the greatness of
    the list perm relative to the list nums
    """
    greatness_num = 0
    for i in range(0, len(nums) - 1):
        if nums[i] < perm[i]:
            greatness_num += 1
    return greatness_num

def greatestPermutation(nums):
    """
    Function to generate a permutation of the list nums
    which has the largest relative "greatness" to nums
    """

    # first, count up how many of each num we have
    num_count = {}
    for num in nums:
        num_count[num] = num_count.get(num, 0) + 1

    # now, build a permutation that maximizes "greatness"
    perm = []
    available = sorted(num_count.keys()) # only sort once
    for num in nums:
        # default to the smallest available number
        num_to_add = available[0]

        # but now look for the smallest available number
        # that's GREATER than the current number
        for avail in available:
            if avail > num:
                num_to_add = avail
                break

        # add num_to_add to the permutation
        perm.append(num_to_add)

        # decrement its count in num_count
        num_count[num_to_add] -= 1

        # if there are no more, remove it from available
        if num_count[num_to_add] == 0:
            available = [
                x for x in available if x != num_to_add
            ]

    return perm


def solution(nums):
    as_list = ', '.join(map(lambda i: str(i), nums))
    print(f'Input: @nums = ({as_list})')
    greatest = greatestPermutation(nums)
    greatness_num = greatness(nums, greatest)
    as_list = ', '.join(map(lambda i: str(i), greatest))
    print(f'Output: {greatness_num}\n')
    print(f'One possible permutation: ({as_list})\n' +
          'which returns $greatness greatness as below:')
    for i in range(0, len(nums) - 1):
        if nums[i] < greatest[i]:
            print(f'nums[{i}] < perm[{i}]')

print('Example 1:')
solution([1, 3, 5, 2, 1, 3, 1])

print('\nExample 2:')
solution([1, 2, 3, 4])