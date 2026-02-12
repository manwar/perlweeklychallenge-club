#!/usr/bin/env python3
"""
Perl Weekly Challenge 092 - Task 2: Insert Interval

Given a list of sorted non-overlapping intervals and a new interval, merge the
new interval into the list.
"""

from __future__ import annotations

from typing import List, Sequence, Tuple

Interval = Tuple[int, int]


def insert_interval(intervals: Sequence[Interval], new_interval: Interval) -> List[Interval]:
    """Insert `new_interval` into sorted non-overlapping `intervals` and merge overlaps."""
    new_start, new_end = new_interval
    out: List[Interval] = []
    inserted = False

    for start, end in intervals:
        if end < new_start:
            out.append((start, end))
            continue

        if new_end < start:
            if not inserted:
                out.append((new_start, new_end))
                inserted = True
            out.append((start, end))
            continue

        new_start = min(new_start, start)
        new_end = max(new_end, end)

    if not inserted:
        out.append((new_start, new_end))

    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge092Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(insert_interval([(1, 4), (8, 10)], (2, 6)), [(1, 6), (8, 10)])

        def test_example_2(self) -> None:
            self.assertEqual(
                insert_interval([(1, 2), (3, 7), (8, 10)], (5, 8)),
                [(1, 2), (3, 10)],
            )

        def test_example_3(self) -> None:
            self.assertEqual(
                insert_interval([(1, 5), (7, 9)], (10, 11)),
                [(1, 5), (7, 9), (10, 11)],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge092Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

