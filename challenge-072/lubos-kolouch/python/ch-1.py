#!/usr/bin/env python3
"""
Perl Weekly Challenge 072 - Task 1: Trailing Zeroes

You are given a positive integer $N (N >= 1).
Write a script to calculate the total number of trailing zeroes in $N!.
"""

import unittest


def trailing_zeros(n: int) -> int:
    """Calculate the number of trailing zeroes in n! by counting factors of 5."""
    if n <= 0:
        return 0

    count = 0
    divisor = 5
    while n >= divisor:
        count += n // divisor
        divisor *= 5

    return count


class TestTrailingZeros(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(trailing_zeros(10), 2)

    def test_example_2(self) -> None:
        self.assertEqual(trailing_zeros(7), 1)

    def test_example_3(self) -> None:
        self.assertEqual(trailing_zeros(4), 0)

    def test_multiple_fives(self) -> None:
        self.assertEqual(trailing_zeros(25), 6)


if __name__ == "__main__":
    unittest.main()

