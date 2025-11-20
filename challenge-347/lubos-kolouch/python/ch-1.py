#!/usr/bin/env python3
"""Format Date - Perl Weekly Challenge 347 task 1."""

from __future__ import annotations

from typing import Final
from collections.abc import Sequence
import re
import sys
import unittest

MONTHS: Final[dict[str, int]] = {
    "Jan": 1,
    "Feb": 2,
    "Mar": 3,
    "Apr": 4,
    "May": 5,
    "Jun": 6,
    "Jul": 7,
    "Aug": 8,
    "Sep": 9,
    "Oct": 10,
    "Nov": 11,
    "Dec": 12,
}

DATE_PATTERN: Final[re.Pattern[str]] = re.compile(
    r"^(?P<day>\d{1,2})(?P<suffix>st|nd|rd|th)\s+(?P<month>[A-Za-z]{3})\s+(?P<year>\d{4})$"
)


def _suffix_for(day: int) -> str:
    if 11 <= day % 100 <= 13:
        return "th"
    suffixes = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"]
    return suffixes[day % 10]


def format_date(text: str) -> str:
    """Convert strings like '10th Nov 2025' to '2025-11-10'."""
    match = DATE_PATTERN.match(text.strip())
    if not match:
        raise ValueError("Invalid date format")

    day = int(match.group("day"))
    suffix = match.group("suffix")
    month_name = match.group("month")
    year = int(match.group("year"))

    if not 1 <= day <= 31:
        raise ValueError("Day out of range")
    if _suffix_for(day) != suffix:
        raise ValueError("Invalid ordinal suffix")

    month = MONTHS.get(month_name)
    if month is None:
        raise ValueError("Unknown month abbreviation")
    if not 1900 <= year <= 2100:
        raise ValueError("Year out of range")

    return f"{year:04d}-{month:02d}-{day:02d}"


class FormatDateExamples(unittest.TestCase):
    """Specification-provided examples."""

    def test_example_1(self) -> None:
        self.assertEqual(format_date("1st Jan 2025"), "2025-01-01")

    def test_example_2(self) -> None:
        self.assertEqual(format_date("22nd Feb 2025"), "2025-02-22")

    def test_example_3(self) -> None:
        self.assertEqual(format_date("15th Apr 2025"), "2025-04-15")

    def test_example_4(self) -> None:
        self.assertEqual(format_date("23rd Oct 2025"), "2025-10-23")

    def test_example_5(self) -> None:
        self.assertEqual(format_date("31st Dec 2025"), "2025-12-31")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface: run tests or format a provided string."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit('Usage: python3 ch-1.py "1st Jan 2025"')

    value = args[0]
    print(f'Input:  $str = "{value}"')
    result = format_date(value)
    print(f'Output: "{result}"')


if __name__ == "__main__":
    main()
