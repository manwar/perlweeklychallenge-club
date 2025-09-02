"""
This script solves the Perl Weekly Challenge 337, Task 1.

Task 1: Smaller Than Current

You are given an array of numbers, `@num1`.

Write a script to return an array, `@num2`, where `$num2[i]` is the count of all  # noqa: E501
numbers less than or equal to `$num1[i]` in the array,
excluding the number itself.

Example 1
Input: `@num1 = (6, 5, 4, 8)`
Output: `(2, 1, 0, 3)`

Example 2
Input: `@num1 = (7, 7, 7, 7)`
Output: `(3, 3, 3, 3)`

Example 3
Input: `@num1 = (5, 4, 3, 2, 1)`
Output: `(4, 3, 2, 1, 0)`

Example 4
Input: `@num1 = (-1, 0, 3, -2, 1)`
Output: `(1, 2, 4, 0, 3)`

Example 5
Input: `@num1 = (0, 1, 1, 2, 0)`
Output: `(1, 3, 3, 4, 1)`
"""

import unittest


def smaller_than_current(nums: list[int]) -> list[int]:
    """
    For each number in a list, count how many other numbers in the list are
    smaller or equal.
    """
    result = []
    for i, num in enumerate(nums):
        count = 0
        for j, other_num in enumerate(nums):
            if i == j:
                continue
            if other_num <= num:
                count += 1
        result.append(count)
    return result


class TestSmallerThanCurrent(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(smaller_than_current([6, 5, 4, 8]), [2, 1, 0, 3])

    def test_example2(self):
        self.assertEqual(smaller_than_current([7, 7, 7, 7]), [3, 3, 3, 3])

    def test_example3(self):
        self.assertEqual(smaller_than_current([5, 4, 3, 2, 1]),
                         [4, 3, 2, 1, 0])

    def test_example4(self):
        self.assertEqual(smaller_than_current([-1, 0, 3, -2, 1]),
                         [1, 2, 4, 0, 3])

    def test_example5(self):
        self.assertEqual(smaller_than_current([0, 1, 1, 2, 0]),
                         [1, 3, 3, 4, 1])


if __name__ == '__main__':
    unittest.main()
