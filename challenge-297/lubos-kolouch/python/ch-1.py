#!/usr/bin/env python3
"""Contiguous Array - Perl Weekly Challenge 297 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def find_max_length(binary: Sequence[int]) -> int:
    """Find the maximum length of a contiguous subarray with equal numbers of 0 and 1."""
    sum_indices: dict[int, int] = {}
    max_length = 0
    cumulative_sum = 0

    for i, val in enumerate(binary):
        if val not in (0, 1):
            raise ValueError("Binary array must contain only 0 and 1")
        cumulative_sum += -1 if val == 0 else 1

        if cumulative_sum == 0:
            max_length = i + 1
        elif cumulative_sum in sum_indices:
            length = i - sum_indices[cumulative_sum]
            if length > max_length:
                max_length = length
        else:
            sum_indices[cumulative_sum] = i

    return max_length


class TestFindMaxLength(unittest.TestCase):
    """Unit tests for find_max_length."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(find_max_length([1, 0]), 2)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(find_max_length([0, 1, 0]), 2)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(find_max_length([0, 0, 0, 0, 0]), 0)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(find_max_length([0, 1, 0, 0, 1, 0]), 4)

    def test_empty(self) -> None:
        """Test empty input."""
        self.assertEqual(find_max_length([]), 0)

    def test_no_equal_subarray(self) -> None:
        """Test no equal subarray."""
        self.assertEqual(find_max_length([0, 0, 0, 1, 1]), 4)

    def test_long_array(self) -> None:
        """Test long array performance."""
        binary = [0, 1] * 1000
        self.assertEqual(find_max_length(binary), 2000)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
