#!/usr/bin/env python3
"""Balls and Boxes - Perl Weekly Challenge 312 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def balls_and_boxes(text: str) -> int:
    """Return number of boxes containing all three colors (R/G/B)."""
    if len(text) % 2 != 0:
        raise ValueError("Expected an even-length string of (Color,Box) pairs")

    boxes: list[set[str]] = [set() for _ in range(10)]
    for idx in range(0, len(text), 2):
        color = text[idx]
        box = text[idx + 1]
        if color not in {"R", "G", "B"}:
            raise ValueError("Invalid color")
        if box not in "0123456789":
            raise ValueError("Invalid box")
        boxes[int(box)].add(color)

    return sum(1 for colors in boxes if {"R", "G", "B"}.issubset(colors))


class BallsAndBoxesExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(balls_and_boxes("G0B1R2R0B0"), 1)

    def test_example_2(self) -> None:
        self.assertEqual(balls_and_boxes("G1R3R6B3G6B1B6R1G3"), 3)

    def test_example_3(self) -> None:
        self.assertEqual(balls_and_boxes("B3B2G1B3"), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <string>")

    text = args[0]
    print(f'Input: $str = "{text}"')
    print(f"Output: {balls_and_boxes(text)}")


if __name__ == "__main__":
    main()
