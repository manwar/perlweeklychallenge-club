#!/usr/bin/env python3
"""Line Counts - The Weekly Challenge 267 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def line_counts(s: str, widths: list[int]) -> tuple[int, int]:
    """Calculate the number of lines and width of the last line for a string.

    Args:
        s: The input string consisting of lowercase English letters.
        widths: A list of 26 integers representing character widths ('a' to 'z').

    Returns:
        A tuple (lines, last_line_width).
    """
    max_width = 100
    current_width = 0
    lines = 1

    for char in s:
        char_width = widths[ord(char) - ord("a")]
        if current_width + char_width > max_width:
            lines += 1
            current_width = char_width
        else:
            current_width += char_width

    return lines, current_width


class TestLineCounts(unittest.TestCase):
    """Unit tests for line_counts."""

    def test_example1(self) -> None:
        """Test Example 1: 'abcdefghijklmnopqrstuvwxyz' with uniform widths 10."""
        widths = [10] * 26
        self.assertEqual(line_counts("abcdefghijklmnopqrstuvwxyz", widths), (3, 60))

    def test_example2(self) -> None:
        """Test Example 2: 'bbbcccdddaaa' with custom widths."""
        widths = [4, 10] + [10] * 24
        self.assertEqual(line_counts("bbbcccdddaaa", widths), (2, 4))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 2:
        s = argv[1]
        widths = [int(x) for x in argv[2:]]
        print(f"Output: {line_counts(s, widths)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
