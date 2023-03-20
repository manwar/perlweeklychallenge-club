#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Tuple, Union


def find_missing_and_duplicate(nums: List[int]) -> Union[Tuple[int, int], int]:
    """
    Finds the duplicate and missing integer in a given sequence of integers.

    Args:
        nums (List[int]): A list of integers with one missing and one duplicate.

    Returns:
        Union[Tuple[int, int], int]: If both a missing and duplicate integer are found, returns a tuple
        containing the duplicate integer followed by the missing integer. If none are found, returns -1.

    Example:
        >>> find_missing_and_duplicate([1, 2, 2, 4])
        (2, 3)
        >>> find_missing_and_duplicate([1, 2, 3, 4])
        -1
        >>> find_missing_and_duplicate([1, 2, 3, 3])
        (3, 4)
    """
    count = {}
    missing = 0
    duplicate = 0
    for num in nums:
        count[num] = count.get(num, 0) + 1
        if count[num] > 1:
            duplicate = num
    for i in range(1, len(nums) + 2):
        if i not in count:
            missing = i
            break
    if missing and duplicate:
        return (duplicate, missing)
    else:
        return -1


# Run the tests


def test_find_missing_and_duplicate():
    assert find_missing_and_duplicate([1, 2, 2, 4]) == (2, 3)
    assert find_missing_and_duplicate([1, 2, 3, 4]) == -1
    assert find_missing_and_duplicate([1, 2, 3, 3]) == (3, 4)


test_find_missing_and_duplicate()
