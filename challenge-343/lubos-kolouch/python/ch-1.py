#!/usr/bin/env python3
"""
Perl Weekly Challenge: Task 1 - Zero Friend
Find the number closest to zero and return its distance to zero.
"""

import unittest


def zero_friend(nums: list[int]) -> int:
    """
    Find the distance to zero of the number closest to zero in the list.

    Args:
        nums (list[int]): List of integers.

    Returns:
        int: The absolute value (distance to zero) of the number closest to zero.
             Returns 0 if the list is empty.
    """
    if not nums:
        return 0

    return min(abs(num) for num in nums)


class TestZeroFriend(unittest.TestCase):
    """Unit tests for the zero_friend function."""

    def test_case_1(self):
        """Test Case 1: (4, 2, -1, 3, -2) -> 1"""
        self.assertEqual(zero_friend([4, 2, -1, 3, -2]), 1)

    def test_case_2(self):
        """Test Case 2: (-5, 5, -3, 3, -1, 1) -> 1"""
        self.assertEqual(zero_friend([-5, 5, -3, 3, -1, 1]), 1)

    def test_case_3(self):
        """Test Case 3: (7, -3, 0, 2, -8) -> 0"""
        self.assertEqual(zero_friend([7, -3, 0, 2, -8]), 0)

    def test_case_4(self):
        """Test Case 4: (-2, -5, -1, -8) -> 1"""
        self.assertEqual(zero_friend([-2, -5, -1, -8]), 1)

    def test_case_5(self):
        """Test Case 5: (-2, 2, -4, 4, -1, 1) -> 1"""
        self.assertEqual(zero_friend([-2, 2, -4, 4, -1, 1]), 1)


if __name__ == '__main__':
    unittest.main()
