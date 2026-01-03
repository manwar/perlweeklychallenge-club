#!/usr/bin/env python3
"""Sort by 1 bits - Perl Weekly Challenge 271 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def sort_by_1_bits(ints: Sequence[int]) -> list[int]:
    """Sort by bit_count then numeric value."""
    return sorted(ints, key=lambda x: (int(x).bit_count(), int(x)))


class SortBy1BitsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(sort_by_1_bits((0, 1, 2, 3, 4, 5, 6, 7, 8)), [0, 1, 2, 4, 8, 3, 5, 6, 7])

    def test_example_2(self) -> None:
        self.assertEqual(sort_by_1_bits((1024, 512, 256, 128, 64)), [64, 128, 256, 512, 1024])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    ints = [int(token) for token in args]
    out = sort_by_1_bits(ints)
    print(f"Output: ({', '.join(str(x) for x in out)})")


if __name__ == "__main__":
    main()

