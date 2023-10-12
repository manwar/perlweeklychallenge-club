#!/usr/bin/env python3

from typing import Iterable


def running_sum(nums: list[int]) -> list[int]:
    """
    You are given an array of integers.

    Write a script to return the running sum of the given array.
    The running sum can be calculated as sum[i] = num[0] + num[1] + …. + num[i]

    Example 1
    Input: @int = (1, 2, 3, 4, 5)
    Output: (1, 3, 6, 10, 15)
    >>> assert (1, 3, 6, 10, 15) == running_sum([1, 2, 3, 4, 5])
    Example 2
    Input: @int = (1, 1, 1, 1, 1)
    Output: (1, 2, 3, 4, 5)
    >>> assert (1, 2, 3, 4, 5) == running_sum([1, 1, 1, 1, 1])
    Example 3
    Input: @int = (0, -1, 1, 2)
    Output: (0, -1, 0, 2)
    >>> assert ( 0, -1, 0, 2) == running_sum([0, -1, 1, 2])
    """
    return list(running_sum_it(nums))


def running_sum_it(nums: list[int]) -> Iterable[int]:
    """
    You are given an array of integers.

    return an iterator of the running sum of the given array.
    The running sum can be calculated as sum[i] = num[0] + num[1] + …. + num[i]

    Example 1
    Input: @int = (1, 2, 3, 4, 5)
    Output: (1, 3, 6, 10, 15)
    >>> assert (1, 3, 6, 10, 15) == list(running_sum([1, 2, 3, 4, 5]))
    Example 2
    Input: @int = (1, 1, 1, 1, 1)
    Output: (1, 2, 3, 4, 5)
    >>> assert (1, 2, 3, 4, 5) == list(running_sum([1, 1, 1, 1, 1]))
    Example 3
    Input: @int = (0, -1, 1, 2)
    Output: (0, -1, 0, 2)
    >>> assert ( 0, -1, 0, 2) == list(running_sum([0, -1, 1, 2]))
    """

    current_sum = 0
    for i in nums:
        current_sum += i
        yield current_sum


if __name__ == "__main__":
    import unittest

    tests = [
        ([1, 2, 3, 4, 5], [1, 3, 6, 10, 15]),
        ([1, 1, 1, 1, 1], [1, 2, 3, 4, 5]),
        ([0, -1, 1, 2], [0, -1, 0, 2]),
    ]
    tester = unittest.TestCase()
    for input, expected in tests:
        tester.assertEqual(expected, running_sum(input))
