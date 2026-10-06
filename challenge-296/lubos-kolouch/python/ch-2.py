#!/usr/bin/env python3
"""Matchstick Square - Perl Weekly Challenge 296 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def can_form_square(nums: Sequence[int]) -> bool:
    """Determine if it is possible to form a square using all sticks."""
    if len(nums) < 4:
        return False

    total_length = sum(nums)
    if total_length % 4 != 0:
        return False

    target_side_length = total_length // 4
    sticks = sorted(nums, reverse=True)

    if sticks[0] > target_side_length:
        return False

    sides = [0] * 4

    def dfs(index: int) -> bool:
        if index == len(sticks):
            return all(side == target_side_length for side in sides)
        for i in range(4):
            if sides[i] + sticks[index] <= target_side_length:
                sides[i] += sticks[index]
                if dfs(index + 1):
                    return True
                sides[i] -= sticks[index]
            if sides[i] == 0:
                break
        return False

    return dfs(0)


class TestMatchstickSquare(unittest.TestCase):
    """Unit tests for can_form_square."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertTrue(can_form_square([1, 2, 2, 2, 1]))

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertFalse(can_form_square([2, 2, 2, 4]))

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertFalse(can_form_square([2, 2, 2, 2, 4]))

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertTrue(can_form_square([3, 4, 1, 4, 3, 1]))

    def test_additional_true(self) -> None:
        """Test additional case returning true."""
        self.assertTrue(can_form_square([1, 1, 2, 2, 2]))

    def test_additional_false(self) -> None:
        """Test additional case returning false."""
        self.assertFalse(can_form_square([3, 3, 3, 3, 4]))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
