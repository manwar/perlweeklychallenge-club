#!/usr/bin/env python

import math
from typing import List


def floor_sum(nums: list[int]) -> int:
    """
    Calculate the sum of floor division results for every combination of elements in the array.

    Args:
    nums (List[int]): A list of positive integers.

    Returns:
    int: The sum of the floor division results.
    """
    return sum(
        math.floor(nums[i] / nums[j])
        for i in range(len(nums))
        for j in range(len(nums))
    )


# Tests
assert floor_sum([2, 5, 9]) == 10
assert floor_sum([7, 7, 7, 7, 7, 7, 7]) == 49
