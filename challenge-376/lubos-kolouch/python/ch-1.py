#!/usr/bin/env python3
"""Chessboard Squares - Perl Weekly Challenge 376 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def square_color_parity(coord: str) -> int:
    """Return the color parity of a chessboard square coordinate (0 for black, 1 for white)."""
    if len(coord) != 2 or coord[0] not in "abcdefgh" or coord[1] not in "12345678":
        raise ValueError("Invalid coordinate format")
    col_num = ord(coord[0]) - ord("a") + 1
    row_num = int(coord[1])
    return (col_num + row_num) % 2


def same_color(c1: str, c2: str) -> bool:
    """Return True if both coordinates have the same color on a chessboard, False otherwise."""
    return square_color_parity(c1) == square_color_parity(c2)


class ChessboardSquaresExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertTrue(same_color("a7", "f4"))

    def test_example_2(self) -> None:
        self.assertFalse(same_color("c1", "e8"))

    def test_example_3(self) -> None:
        self.assertFalse(same_color("b5", "h2"))

    def test_example_4(self) -> None:
        self.assertTrue(same_color("f3", "h1"))

    def test_example_5(self) -> None:
        self.assertFalse(same_color("a1", "g8"))


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
