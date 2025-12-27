#!/usr/bin/env python3
"""Rank Array - Perl Weekly Challenge 322 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def rank_array(values: Sequence[int]) -> list[int]:
    """Return ranks for each element, with ties sharing the same rank."""
    unique_sorted = sorted(set(values))
    rank_of = {value: idx + 1 for idx, value in enumerate(unique_sorted)}
    return [rank_of[value] for value in values]


class RankArrayExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(rank_array((55, 22, 44, 33)), [4, 1, 3, 2])

    def test_example_2(self) -> None:
        self.assertEqual(rank_array((10, 10, 10)), [1, 1, 1])

    def test_example_3(self) -> None:
        self.assertEqual(rank_array((5, 1, 1, 4, 3)), [4, 1, 1, 3, 2])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    numbers = [int(value) for value in args]
    result = rank_array(numbers)
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: ({', '.join(str(x) for x in result)})")


if __name__ == "__main__":
    main()
