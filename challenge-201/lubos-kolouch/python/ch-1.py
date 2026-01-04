#!/usr/bin/env python3
"""Missing Numbers - Perl Weekly Challenge 201 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def missing_number(array: Sequence[int]) -> int:
    """Return the missing number in range 0..n where n = len(array)."""
    n = len(array)
    expected = n * (n + 1) // 2
    return expected - sum(array)


class MissingNumberExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(missing_number((0, 1, 3)), 2)

    def test_example_2(self) -> None:
        self.assertEqual(missing_number((0, 1)), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    array = [int(token) for token in args]
    print(f"Input:  @array = ({', '.join(str(x) for x in array)})")
    print(f"Output: {missing_number(array)}")


if __name__ == "__main__":
    main()

