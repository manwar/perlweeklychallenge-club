#!/usr/bin/env python3
"""Perl Weekly Challenge 006 - Task 1: Compact number lists.

Takes a list of numbers and returns them in compact form.
Consecutive runs of 3 or more numbers are represented as 'start-end'.
Pairs of 2 consecutive numbers remain 'a,b'.
"""

from __future__ import annotations

import unittest


def compact_number_list(numbers: list[int]) -> str:
    """Compact a list of integers into ranges.

    :param numbers: List of integers.
    :return: Formatted string with compacted ranges.
    """
    if not numbers:
        return ""

    sorted_nums = sorted(numbers)
    compact: list[str] = []
    start = sorted_nums[0]
    end = sorted_nums[0]

    def append_range(s: int, e: int) -> None:
        if e - s >= 2:
            compact.append(f"{s}-{e}")
        elif e - s == 1:
            compact.extend([str(s), str(e)])
        else:
            compact.append(str(s))

    for num in sorted_nums[1:]:
        if num == end + 1:
            end = num
        elif num == end:
            continue
        else:
            append_range(start, end)
            start = end = num

    append_range(start, end)
    return ",".join(compact)


class TestCompactNumberList(unittest.TestCase):
    """Test cases for compact_number_list."""

    def test_example_1(self) -> None:
        self.assertEqual(
            compact_number_list([1, 2, 3, 4, 9, 10, 14, 15, 16]),
            "1-4,9,10,14-16",
        )

    def test_continuous(self) -> None:
        self.assertEqual(compact_number_list([1, 2, 3]), "1-3")

    def test_pair(self) -> None:
        self.assertEqual(compact_number_list([1, 2]), "1,2")

    def test_single(self) -> None:
        self.assertEqual(compact_number_list([5]), "5")

    def test_isolated(self) -> None:
        self.assertEqual(compact_number_list([1, 3, 5]), "1,3,5")

    def test_empty(self) -> None:
        self.assertEqual(compact_number_list([]), "")


if __name__ == "__main__":
    unittest.main()
