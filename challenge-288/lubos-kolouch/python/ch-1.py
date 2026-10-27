#!/usr/bin/env python3
"""Closest Palindrome - The Weekly Challenge 288 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def closest_palindrome(n_str: str) -> str:
    """Find the closest palindrome integer string to n_str, excluding itself.

    If multiple palindromes have the same minimal absolute difference,
    the smaller one is returned.

    Args:
        n_str: The input integer as a string.

    Returns:
        The closest palindrome integer as a string.
    """
    n = int(n_str)
    length = len(n_str)
    is_even = length % 2 == 0
    mid = length // 2
    left_len = mid if is_even else mid + 1
    left = n_str[:left_len]
    candidates: set[str] = set()

    for diff in (-1, 0, 1):
        new_left = str(int(left) + diff)
        if len(new_left) != left_len and diff != 0:
            continue
        if is_even:
            pal = new_left + new_left[::-1]
        else:
            pal = new_left + new_left[:-1][::-1]
        candidates.add(pal)

    # Edge cases (e.g. 100 -> 99, 99 -> 101)
    if length > 1:
        candidates.add("9" * (length - 1))
    candidates.add("1" + ("0" * (length - 1)) + "1")

    candidates.discard(n_str)

    min_diff: int | None = None
    closest_pal = ""
    for cand in sorted(candidates, key=lambda x: (abs(int(x) - n), int(x))):
        if not cand:
            continue
        diff = abs(int(cand) - n)
        if diff == 0:
            continue
        if min_diff is None or diff < min_diff:
            min_diff = diff
            closest_pal = cand

    return closest_pal


class TestClosestPalindrome(unittest.TestCase):
    """Unit tests for closest_palindrome."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(closest_palindrome("123"), "121")

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(closest_palindrome("2"), "1")

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(closest_palindrome("1400"), "1441")

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(closest_palindrome("1001"), "999")

    def test_large_number(self) -> None:
        """Test large number with 9s."""
        self.assertEqual(closest_palindrome("999"), "1001")

    def test_all_nines(self) -> None:
        """Test four 9s."""
        self.assertEqual(closest_palindrome("9999"), "10001")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        print(f"Output: {closest_palindrome(argv[1])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
