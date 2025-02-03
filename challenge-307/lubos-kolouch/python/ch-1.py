#!/usr/bin/env python3
"""
Module to check the order of an integer list.
"""

import unittest

IntList = list[int]


def check_order(ints: IntList) -> list[int]:
    """
    Rearranges the list in increasing order and returns the indices where the sorted list
    differs from the original list.

    Args:
        ints (List[int]): The list of integers.

    Returns:
        List[int]: A list of indices where the sorted list differs from the original.
    """
    sorted_ints = sorted(ints)
    differences: list[int] = []
    for i, (orig, sorted_val) in enumerate(zip(ints, sorted_ints)):
        if orig != sorted_val:
            differences.append(i)
    return differences


if __name__ == "__main__":

    class TestCheckOrder(unittest.TestCase):

        def test_example1(self):
            input_list = [5, 2, 4, 3, 1]
            expected = [0, 2, 3, 4]
            self.assertEqual(check_order(input_list), expected)

        def test_example2(self):
            input_list = [1, 2, 1, 1, 3]
            expected = [1, 3]
            self.assertEqual(check_order(input_list), expected)

        def test_example3(self):
            input_list = [3, 1, 3, 2, 3]
            expected = [0, 1, 3]
            self.assertEqual(check_order(input_list), expected)

        def test_already_sorted(self):
            input_list = [1, 2, 3, 4, 5]
            expected = []
            self.assertEqual(check_order(input_list), expected)


if __name__ == "__main__":
    unittest.main()
