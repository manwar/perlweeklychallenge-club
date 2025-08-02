#!/usr/bin/env python

import unittest


def can_form_square(nums: list[int]) -> bool:
    """
    Determines if it's possible to form a square using all the sticks provided in the list,
    where each stick's length is given, and each side of the square is formed
    by combining one or more sticks.

    Args:
        nums (List[int]): List of integers representing stick lengths.

    Returns:
        bool: True if it's possible to form a square, False otherwise.
    """
    total_length = sum(nums)
    if total_length % 4 != 0:
        return False

    target_side_length = total_length // 4

    nums.sort(reverse=True)

    if nums[0] > target_side_length:
        return False

    sides = [0] * 4

    def dfs(index: int) -> bool:
        if index == len(nums):
            return all(side == target_side_length for side in sides)
        for i in range(4):
            if sides[i] + nums[index] <= target_side_length:
                sides[i] += nums[index]
                if dfs(index + 1):
                    return True
                sides[i] -= nums[index]
            if sides[i] == 0:
                break
        return False

    return dfs(0)


# Unit Tests


class TestMatchstickSquare(unittest.TestCase):

    def test_example1(self):
        self.assertTrue(can_form_square([1, 2, 2, 2, 1]), 'Example 1')

    def test_example2(self):
        self.assertFalse(can_form_square([2, 2, 2, 4]), 'Example 2')

    def test_example3(self):
        self.assertFalse(can_form_square([2, 2, 2, 2, 4]), 'Example 3')

    def test_example4(self):
        self.assertTrue(can_form_square([3, 4, 1, 4, 3, 1]), 'Example 4')

    def test_additional(self):
        self.assertTrue(can_form_square([1, 1, 2, 2, 2]), 'Additional Test - True')
        self.assertFalse(can_form_square([3, 3, 3, 3, 4]), 'Additional Test - False')


if __name__ == "__main__":
    unittest.main()
