#!/usr/bin/env python3
"""Target Index - Perl Weekly Challenge 263 Task 1."""

from __future__ import annotations

import unittest


def find_target_indices(ints: list[int], k: int) -> list[int]:
    """Return the indices in the sorted array where the element equals k."""
    sorted_ints = sorted(ints)
    return [i for i, val in enumerate(sorted_ints) if val == k]


class TestFindTargetIndices(unittest.TestCase):
    """Unit tests for find_target_indices."""

    def test_example_1(self) -> None:
        """Test Example 1: [1, 5, 3, 2, 4, 2], k=2 -> [1, 2]."""
        self.assertEqual(find_target_indices([1, 5, 3, 2, 4, 2], 2), [1, 2])

    def test_example_2(self) -> None:
        """Test Example 2: [1, 2, 4, 3, 5], k=6 -> []."""
        self.assertEqual(find_target_indices([1, 2, 4, 3, 5], 6), [])

    def test_example_3(self) -> None:
        """Test Example 3: [5, 3, 2, 4, 2, 1], k=4 -> [4]."""
        self.assertEqual(find_target_indices([5, 3, 2, 4, 2, 1], 4), [4])

    def test_empty_list(self) -> None:
        """Test empty input list returns empty list."""
        self.assertEqual(find_target_indices([], 1), [])


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
