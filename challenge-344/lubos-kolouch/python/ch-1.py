#!/usr/bin/env python3
"""
Perl Weekly Challenge: Task 1 - Array Form Compute
Add an integer to its array-form representation and return the resulting digits.
"""

from __future__ import annotations

import unittest


def array_form_compute(ints: list[int], x: int) -> list[int]:
    """
    Add the integer ``x`` to the number represented by ``ints`` in array form.

    Args:
        ints (list[int]): Digits of the number ordered from most to least significant.
        x (int): The value to add.

    Returns:
        list[int]: Digits of the resulting sum in array form.
    """
    result: list[int] = []
    carry = x
    index = len(ints) - 1

    while index >= 0 or carry > 0:
        if index >= 0:
            carry += ints[index]
            index -= 1
        result.append(carry % 10)
        carry //= 10

    if not result:
        return [0]

    result.reverse()
    return result


class TestArrayFormCompute(unittest.TestCase):
    """Unit tests for the array_form_compute function."""

    def test_example_1(self) -> None:
        """Example 1: (1, 2, 3, 4) + 12 -> (1, 2, 4, 6)"""
        self.assertEqual(array_form_compute([1, 2, 3, 4], 12), [1, 2, 4, 6])

    def test_example_2(self) -> None:
        """Example 2: (2, 7, 4) + 181 -> (4, 5, 5)"""
        self.assertEqual(array_form_compute([2, 7, 4], 181), [4, 5, 5])

    def test_example_3(self) -> None:
        """Example 3: (9, 9, 9) + 1 -> (1, 0, 0, 0)"""
        self.assertEqual(array_form_compute([9, 9, 9], 1), [1, 0, 0, 0])

    def test_example_4(self) -> None:
        """Example 4: (1, 0, 0, 0, 0) + 9999 -> (1, 9, 9, 9, 9)"""
        self.assertEqual(array_form_compute([1, 0, 0, 0, 0], 9999),
                         [1, 9, 9, 9, 9])

    def test_example_5(self) -> None:
        """Example 5: (0) + 1000 -> (1, 0, 0, 0)"""
        self.assertEqual(array_form_compute([0], 1000), [1, 0, 0, 0])


if __name__ == "__main__":
    unittest.main()
