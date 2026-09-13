#!/usr/bin/env python3
"""Perl Weekly Challenge 075 - Task 2: Largest Rectangle Histogram.

Find the largest rectangular area possible in a given histogram.
"""

from __future__ import annotations

import unittest


def format_histogram(histogram: list[int]) -> str:
    """Format the histogram visually as an ASCII diagram.

    :param histogram: List of bar heights.
    :return: Formatted multiline ASCII string.
    """
    if not histogram:
        return ""

    hist_max = max(histogram)
    max_len = len(str(hist_max)) + 1
    lines: list[str] = []

    for i in range(hist_max, 0, -1):
        line = f"{i:>{max_len}}"
        for bar in histogram:
            line += f"{'#':>{max_len}}" if bar >= i else f"{' ':>{max_len}}"
        lines.append(line)

    lines.append("_" * (max_len * (len(histogram) + 1)))

    bottom_row = " " * max_len
    for item in histogram:
        bottom_row += f"{item:>{max_len}}"
    lines.append(bottom_row)

    return "\n".join(lines)


def largest_rectangle(histogram: list[int]) -> int:
    """Compute the maximum area of a rectangle formed within the histogram.

    Uses a monotonic increasing stack in O(N) time.

    :param histogram: List of bar heights.
    :return: Maximum rectangular area.
    """
    if not histogram:
        return 0

    stack: list[int] = []
    max_area = 0
    n = len(histogram)

    for i in range(n + 1):
        curr_height = 0 if i == n else histogram[i]

        while stack and histogram[stack[-1]] > curr_height:
            top_idx = stack.pop()
            h = histogram[top_idx]
            w = (i - stack[-1] - 1) if stack else i
            max_area = max(max_area, h * w)

        stack.append(i)

    return max_area


class TestLargestRectangle(unittest.TestCase):
    """Test cases for largest_rectangle."""

    def test_example_1(self) -> None:
        self.assertEqual(largest_rectangle([2, 1, 4, 5, 3, 7]), 12)

    def test_example_2(self) -> None:
        self.assertEqual(largest_rectangle([3, 2, 3, 5, 7, 5]), 15)

    def test_single_bar(self) -> None:
        self.assertEqual(largest_rectangle([2]), 2)

    def test_two_bars(self) -> None:
        self.assertEqual(largest_rectangle([2, 4]), 4)

    def test_empty(self) -> None:
        self.assertEqual(largest_rectangle([]), 0)


if __name__ == "__main__":
    unittest.main()
