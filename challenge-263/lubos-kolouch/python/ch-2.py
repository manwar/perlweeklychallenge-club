#!/usr/bin/env python3
"""Merge Items - Perl Weekly Challenge 263 Task 2."""

from __future__ import annotations

import unittest


def merge_items(items1: list[list[int]], items2: list[list[int]]) -> list[list[int]]:
    """Merge two 2-D arrays of [item_id, quantity] pairs sorted by item_id."""
    merged: dict[int, int] = {}
    for item_id, quantity in items1 + items2:
        merged[item_id] = merged.get(item_id, 0) + quantity
    return [[item_id, quantity] for item_id, quantity in sorted(merged.items())]


class TestMergeItems(unittest.TestCase):
    """Unit tests for merge_items."""

    def test_example_1(self) -> None:
        """Test Example 1 from challenge description."""
        self.assertEqual(
            merge_items([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]),
            [[1, 4], [2, 3], [3, 2]],
        )

    def test_example_2(self) -> None:
        """Test Example 2 from challenge description."""
        self.assertEqual(
            merge_items([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]),
            [[1, 8], [2, 3], [3, 3]],
        )

    def test_example_3(self) -> None:
        """Test Example 3 from challenge description."""
        self.assertEqual(
            merge_items([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]),
            [[1, 1], [2, 9], [3, 3]],
        )

    def test_empty_lists(self) -> None:
        """Test empty item lists return empty list."""
        self.assertEqual(merge_items([], []), [])


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
