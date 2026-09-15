#!/usr/bin/env python3
"""Perl Weekly Challenge 391 - Task 2: Nested Boxes.

Find the maximum number of boxes that can fit inside each other in a single stack.
"""

from __future__ import annotations

import bisect
import unittest


def max_nested_boxes(boxes: list[list[int]]) -> int:
    """Determine the maximum number of boxes that can nest strictly within each other.

    A box (w1, h1) fits inside (w2, h2) iff w1 < w2 and h1 < h2.
    Using width ascending and height descending sorting, this reduces to
    the Longest Increasing Subsequence (LIS) on heights, solved in O(N log N).

    :param boxes: List of [width, height] box dimensions.
    :return: Maximum chain length of nested boxes.
    """
    if not boxes:
        return 0

    sorted_boxes = sorted(boxes, key=lambda b: (b[0], -b[1]))

    tails: list[int] = []
    for _, h in sorted_boxes:
        idx = bisect.bisect_left(tails, h)
        if idx == len(tails):
            tails.append(h)
        else:
            tails[idx] = h

    return len(tails)


class TestNestedBoxes(unittest.TestCase):
    """Test cases for max_nested_boxes."""

    def test_example_1(self) -> None:
        self.assertEqual(max_nested_boxes([[1, 3], [3, 5], [6, 8], [2, 4]]), 4)

    def test_example_2(self) -> None:
        self.assertEqual(max_nested_boxes([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]), 3)

    def test_example_3(self) -> None:
        self.assertEqual(max_nested_boxes([[5, 5], [5, 5], [5, 5]]), 1)

    def test_example_4(self) -> None:
        self.assertEqual(
            max_nested_boxes([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]), 4
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            max_nested_boxes([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]), 3
        )


if __name__ == "__main__":
    unittest.main()
