#!/usr/bin/env python3
"""Target Array - Perl Weekly Challenge 264 Task 2."""

from __future__ import annotations

import unittest


def create_target_array(source: list[int], indices: list[int]) -> list[int]:
    """Create target array by inserting source[i] at index indices[i]."""
    target: list[int] = []
    for s, idx in zip(source, indices):
        target.insert(idx, s)
    return target


class TestCreateTargetArray(unittest.TestCase):
    """Unit tests for create_target_array."""

    def test_example_1(self) -> None:
        """Test Example 1 from challenge description."""
        self.assertEqual(
            create_target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]),
            [0, 4, 1, 3, 2],
        )

    def test_example_2(self) -> None:
        """Test Example 2 from challenge description."""
        self.assertEqual(
            create_target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]),
            [0, 1, 2, 3, 4],
        )

    def test_example_3(self) -> None:
        """Test Example 3 from challenge description."""
        self.assertEqual(create_target_array([1], [0]), [1])

    def test_empty_arrays(self) -> None:
        """Test empty source and indices lists."""
        self.assertEqual(create_target_array([], []), [])


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
