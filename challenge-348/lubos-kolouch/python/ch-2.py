#!/usr/bin/env python3
"""Convert Time - Perl Weekly Challenge 348 task 2."""

from __future__ import annotations

from typing import Final
from collections.abc import Sequence
import sys
import unittest

MINUTES_PER_DAY: Final[int] = 24 * 60
ALLOWED_STEPS: Final[tuple[int, ...]] = (60, 15, 5, 1)


def minutes_from_midnight(stamp: str) -> int:
    """Convert a HH:MM timestamp into total minutes past midnight."""
    if len(stamp) != 5 or stamp[2] != ":":
        raise ValueError("Time must be in HH:MM format")

    hours_str, minutes_str = stamp.split(":", 1)
    if not (hours_str.isdigit() and minutes_str.isdigit()):
        raise ValueError("Time must only contain digits")

    hours = int(hours_str)
    minutes = int(minutes_str)
    if not (0 <= hours <= 23 and 0 <= minutes <= 59):
        raise ValueError("Time components out of range")

    return hours * 60 + minutes


def convert_time(source: str, target: str) -> int:
    """Return the minimal number of operations to transform source into target."""
    start = minutes_from_midnight(source)
    end = minutes_from_midnight(target)
    diff = end - start
    if diff < 0:
        diff += MINUTES_PER_DAY

    operations = 0
    remaining = diff
    for step in ALLOWED_STEPS:
        operations += remaining // step
        remaining %= step
    return operations


class ConvertTimeExamples(unittest.TestCase):
    """Example-based tests for the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(convert_time("02:30", "02:45"), 1)

    def test_example_2(self) -> None:
        self.assertEqual(convert_time("11:55", "12:15"), 2)

    def test_example_3(self) -> None:
        self.assertEqual(convert_time("09:00", "13:00"), 4)

    def test_example_4(self) -> None:
        self.assertEqual(convert_time("23:45", "00:30"), 3)

    def test_example_5(self) -> None:
        self.assertEqual(convert_time("14:20", "15:25"), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line launcher."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <source> <target>")

    source, target = args
    print(f'Input:  $source = "{source}"')
    print(f'        $target = "{target}"')
    steps = convert_time(source, target)
    print(f"Output: {steps}")


if __name__ == "__main__":
    main()
