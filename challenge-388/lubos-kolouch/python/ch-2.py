#!/usr/bin/env python3
"""Perl Weekly Challenge 388 - Task 2: Secret Santa.

Return the total number of valid gift assignments where no employee
receives the gift they originally bought (derangements).
"""

from __future__ import annotations

import unittest


def secret_santa(n: int) -> int:
    """Return the number of derangements for n items.

    :param n: Number of employees/gifts.
    :return: Total number of valid Secret Santa permutations.
    """
    if n <= 1:
        return 0
    if n == 2:
        return 1

    prev2 = 0  # D(1)
    prev1 = 1  # D(2)
    curr = 1

    for i in range(3, n + 1):
        curr = (i - 1) * (prev1 + prev2)
        prev2 = prev1
        prev1 = curr

    return curr


class TestSecretSanta(unittest.TestCase):
    """Test cases for secret_santa."""

    def test_example_1(self) -> None:
        self.assertEqual(secret_santa(1), 0)

    def test_example_2(self) -> None:
        self.assertEqual(secret_santa(2), 1)

    def test_example_3(self) -> None:
        self.assertEqual(secret_santa(3), 2)

    def test_example_4(self) -> None:
        self.assertEqual(secret_santa(4), 9)

    def test_example_5(self) -> None:
        self.assertEqual(secret_santa(5), 44)

    def test_n_6(self) -> None:
        self.assertEqual(secret_santa(6), 265)


if __name__ == "__main__":
    unittest.main()
