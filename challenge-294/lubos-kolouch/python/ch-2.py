#!/usr/bin/env python3
"""Next Permutation - Perl Weekly Challenge 294 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def next_permutation(ints: list[int]) -> list[int]:
    """Rearrange numbers into lexicographically next greater permutation in place."""
    n = len(ints)
    if n <= 1:
        return ints

    # Step 1: Find largest index i such that ints[i] < ints[i + 1]
    i = n - 2
    while i >= 0 and ints[i] >= ints[i + 1]:
        i -= 1

    if i < 0:
        # Last permutation, return sorted ascending
        return sorted(ints)

    # Step 2: Find largest index j > i such that ints[i] < ints[j]
    j = n - 1
    while ints[j] <= ints[i]:
        j -= 1

    # Step 3: Swap ints[i] and ints[j]
    ints[i], ints[j] = ints[j], ints[i]

    # Step 4: Reverse suffix from ints[i + 1] to end
    ints[i + 1 :] = reversed(ints[i + 1 :])

    return ints


class TestNextPermutation(unittest.TestCase):
    """Unit tests for next_permutation."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(next_permutation([1, 2, 3]), [1, 3, 2])

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(next_permutation([2, 1, 3]), [2, 3, 1])

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(next_permutation([3, 1, 2]), [3, 2, 1])

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(next_permutation([3, 2, 1]), [1, 2, 3])

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(next_permutation([1, 1, 5]), [1, 5, 1])

    def test_example6(self) -> None:
        """Test example 6."""
        self.assertEqual(next_permutation([1, 5, 1]), [5, 1, 1])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: ({', '.join(str(x) for x in next_permutation(ints))})")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
