#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def can_replace_zeroes(numbers: List[int], count: int) -> int:
    """
    Determine whether it is possible to replace the specified number of zeroes
    in the given list of numbers containing only zeroes and ones.

    Args:
        numbers (List[int]): The list of numbers containing only zeroes and ones.
        count (int): The number of zeroes to replace.

    Returns:
        int: 1 if it is possible to replace the specified number of zeroes, 0 otherwise.
    """
    if count == 0:
        return 1

    groups = []
    consecutive_zeroes = 0

    for num in numbers:
        if num == 0:
            consecutive_zeroes += 1
        else:
            if consecutive_zeroes > 0:
                groups.append(consecutive_zeroes)
                consecutive_zeroes = 0

    if consecutive_zeroes > 0:
        groups.append(consecutive_zeroes)

    if len(groups) == 1 and groups[0] == len(numbers):
        return 1 if (groups[0] + 1) // 2 >= count else 0

    replaceable_zeroes = 0
    for i, group in enumerate(groups):
        if i == 0 or i == len(groups) - 1:
            replaceable_zeroes += group // 2
        else:
            replaceable_zeroes += (group - 1) // 2

    return 1 if replaceable_zeroes >= count else 0


# Test cases
numbers1 = [1, 0, 0, 0, 1]
count1 = 1
numbers2 = [1, 0, 0, 0, 1]
count2 = 2
numbers3 = [1, 0, 0, 0, 0, 0, 0, 0, 1]
count3 = 3

print(can_replace_zeroes(numbers1, count1))  # Output: 1
print(can_replace_zeroes(numbers2, count2))  # Output: 0
print(can_replace_zeroes(numbers3, count3))  # Output: 1
