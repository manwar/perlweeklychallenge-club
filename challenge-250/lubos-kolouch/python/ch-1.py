#!/usr/bin/env python3
"""Smallest Index - Perl Weekly Challenge 250, Task 1."""

from __future__ import annotations

import unittest


def smallest_index(ints: list[int]) -> int:
    """Return the smallest index i such that i % 10 == ints[i], or -1."""
    for i, value in enumerate(ints):
        if i % 10 == value:
            return i
    return -1


class TestSmallestIndex(unittest.TestCase):
    """Unit tests for the smallest_index function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[int], int]] = [
            ([0, 1, 2], 0),
            ([4, 3, 2, 1], 2),
            ([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], -1),
            ([], -1),
        ]
        for ints, expected in cases:
            with self.subTest(ints=ints):
                self.assertEqual(smallest_index(ints), expected)


if __name__ == "__main__":
    unittest.main()
