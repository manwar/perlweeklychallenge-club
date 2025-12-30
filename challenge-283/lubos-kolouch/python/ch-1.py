#!/usr/bin/env python3
"""Unique Number - Perl Weekly Challenge 283 task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def unique_number(ints: Sequence[int]) -> int:
    """Return the element that appears exactly once."""
    counts = Counter(ints)
    for value in ints:
        if counts[value] == 1:
            return value
    raise ValueError("No unique element found")


class UniqueNumberExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(unique_number((3, 3, 1)), 1)

    def test_example_2(self) -> None:
        self.assertEqual(unique_number((3, 2, 4, 2, 4)), 3)

    def test_example_3(self) -> None:
        self.assertEqual(unique_number((1,)), 1)

    def test_example_4(self) -> None:
        self.assertEqual(unique_number((4, 3, 1, 1, 1, 4)), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {unique_number(ints)}")


if __name__ == "__main__":
    main()
