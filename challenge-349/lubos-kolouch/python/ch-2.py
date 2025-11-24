#!/usr/bin/env python3
"""Meeting Point - Perl Weekly Challenge 349 task 2."""

from __future__ import annotations

from collections.abc import Sequence
from typing import Final
import sys
import unittest

MOVES: Final[dict[str, tuple[int, int]]] = {
    "U": (0, 1),
    "D": (0, -1),
    "L": (-1, 0),
    "R": (1, 0),
}


def returns_to_origin(path: str) -> bool:
    """Return True when ``path`` visits the starting point at any time."""
    x = 0
    y = 0
    if not path:
        return True
    for step in path:
        if step not in MOVES:
            raise ValueError(
                "Path must consist of U, D, L, or R characters only")
        dx, dy = MOVES[step]
        x += dx
        y += dy
        if x == 0 and y == 0:
            return True
    return False


class MeetingPointExamples(unittest.TestCase):
    """Example-based tests from the task description."""

    def test_example_1(self) -> None:
        self.assertFalse(returns_to_origin("ULD"))

    def test_example_2(self) -> None:
        self.assertTrue(returns_to_origin("ULDR"))

    def test_example_3(self) -> None:
        self.assertFalse(returns_to_origin("UUURRRDDD"))

    def test_example_4(self) -> None:
        self.assertTrue(returns_to_origin("UURRRDDLLL"))

    def test_example_5(self) -> None:
        self.assertTrue(returns_to_origin("RRUULLDDRRUU"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <path>")

    path = args[0]
    print(f'Input:  $path = "{path}"')
    result = "true" if returns_to_origin(path) else "false"
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
