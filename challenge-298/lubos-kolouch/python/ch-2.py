#!/usr/bin/env python3
"""Right Interval - Perl Weekly Challenge 298 task 2."""

from __future__ import annotations

from bisect import bisect_left
from collections.abc import Sequence
import sys
import unittest


Interval = tuple[int, int]


def right_interval_indices(intervals: Sequence[Interval]) -> list[int]:
    """Return index of the right interval for each interval, or -1."""
    if not intervals:
        return []

    starts = sorted((start, idx) for idx, (start, _end) in enumerate(intervals))
    sorted_starts = [start for start, _idx in starts]

    result: list[int] = []
    for _start, end in intervals:
        pos = bisect_left(sorted_starts, end)
        result.append(starts[pos][1] if pos < len(starts) else -1)
    return result


class RightIntervalExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(right_interval_indices(((3, 4), (2, 3), (1, 2))), [-1, 0, 1])

    def test_example_2(self) -> None:
        self.assertEqual(right_interval_indices(((1, 4), (2, 3), (3, 4))), [-1, 2, -1])

    def test_example_3(self) -> None:
        self.assertEqual(right_interval_indices(((1, 2),)), [-1])

    def test_example_4(self) -> None:
        self.assertEqual(right_interval_indices(((1, 4), (2, 2), (3, 4))), [-1, 1, -1])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
