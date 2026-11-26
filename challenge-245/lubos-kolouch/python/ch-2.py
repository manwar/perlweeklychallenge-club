#!/usr/bin/env python3
"""Largest of Three - Perl Weekly Challenge 245, Task 2."""

from __future__ import annotations

from functools import cmp_to_key
import unittest


def _compare_concat(a: int, b: int) -> int:
    """Compare two integers by reverse concatenated string order."""
    ab = f"{a}{b}"
    ba = f"{b}{a}"
    if ba > ab:
        return 1
    if ba < ab:
        return -1
    return 0


def largest_multiple_of_three(ints: list[int]) -> int:
    """Return the largest multiple of 3 formed by concatenating a subset of ints, or -1."""
    sorted_ints = sorted(ints, key=cmp_to_key(_compare_concat))
    if not sorted_ints:
        return -1

    def remove_smallest(remainder: int) -> bool:
        """Remove the last (smallest) element with the given modulo-3 remainder."""
        for i in range(len(sorted_ints) - 1, -1, -1):
            if sorted_ints[i] % 3 == remainder:
                del sorted_ints[i]
                return True
        return False

    total = sum(sorted_ints)
    if total % 3 == 1:
        if not remove_smallest(1):
            if not (remove_smallest(2) and remove_smallest(2)):
                return -1
    elif total % 3 == 2:
        if not remove_smallest(2):
            if not (remove_smallest(1) and remove_smallest(1)):
                return -1

    if not sorted_ints or sum(sorted_ints) % 3 != 0:
        return -1
    return int("".join(map(str, sorted_ints)))


class TestLargestMultipleOfThree(unittest.TestCase):
    """Unit tests for the largest_multiple_of_three function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], int]] = [
            ([8, 1, 9], 981),
            ([8, 6, 7, 1, 0], 8760),
            ([1], -1),
        ]
        for ints, expected in cases:
            with self.subTest(ints=ints):
                self.assertEqual(largest_multiple_of_three(ints), expected)


if __name__ == "__main__":
    unittest.main()
