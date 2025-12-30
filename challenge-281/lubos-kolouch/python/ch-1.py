#!/usr/bin/env python3
"""Check Color - Perl Weekly Challenge 281 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def check_color(coordinates: str) -> bool:
    """Return True if the chessboard square is light, otherwise False.

    Standard chessboard coloring is used where 'a1' is dark.
    """
    c = coordinates.strip().lower()
    if len(c) != 2 or c[0] < "a" or c[0] > "h" or c[1] < "1" or c[1] > "8":
        raise ValueError("Expected coordinates like a1..h8")

    file_num = ord(c[0]) - ord("a") + 1
    rank_num = int(c[1])
    return (file_num + rank_num) % 2 == 1


class CheckColorExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(check_color("d3"))

    def test_example_2(self) -> None:
        self.assertFalse(check_color("g5"))

    def test_example_3(self) -> None:
        self.assertTrue(check_color("e6"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <coordinates>")
    coordinates = args[0]
    print(f'Input:  $coordinates = "{coordinates}"')
    print(f"Output: {'true' if check_color(coordinates) else 'false'}")


if __name__ == "__main__":
    main()

