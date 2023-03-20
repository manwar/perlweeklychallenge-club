#!/usr/bin/env python

import unittest
import sys


def forward_difference(order, nums):
    # Check if valid order is passed
    if order < 1:
        raise ValueError("Order should be a positive integer")

    diff = nums

    # Calculate the nth order forward difference series
    for i in range(order):
        temp = []
        for j in range(len(diff) - 1):
            try:
                temp.append(diff[j + 1] - diff[j])
            except TypeError:
                raise TypeError(f"not a number")
        diff = temp

    # Return the final series
    return diff


# Main code
if __name__ == '__main__':
    # Parse command line arguments
    nums = []
    for arg in sys.argv[1:-1]:
        try:
            nums.append(int(arg))
        except ValueError:
            raise ValueError(f"Invalid argument: {arg!r}")
    order = int(sys.argv[-1])

    # Calculate the nth order forward difference series
    diff = forward_difference(order, nums)

    # Print the final series
    print(', '.join(map(str, diff)))

# Tests


class TestForwardDifference(unittest.TestCase):

    def test_first_order(self):
        nums = [5, 9, 2, 8, 1, 6]
        expected_diff = [4, -7, 6, -7, 5]
        actual_diff = forward_difference(1, nums)
        self.assertListEqual(expected_diff, actual_diff)

    def test_second_order(self):
        nums = [5, 9, 2, 8, 1, 6]
        expected_diff = [-11, 13, -13, 12]
        actual_diff = forward_difference(2, nums)
        self.assertListEqual(expected_diff, actual_diff)

    def test_invalid_order(self):
        nums = [5, 9, 2, 8, 1, 6]
        with self.assertRaises(ValueError):
            forward_difference(-1, nums)

    def test_non_numeric_parameters(self):
        nums = [5, 9, 2, 8, "foo", 6]
        with self.assertRaises(TypeError):
            forward_difference(2, nums)


if __name__ == '__main__':
    unittest.main()
