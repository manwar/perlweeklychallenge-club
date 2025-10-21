#!/usr/bin/env python3
"""Task 1 - Binary Date converter for The Weekly Challenge #332."""
from __future__ import annotations

import re
import unittest
from typing import Final

DATE_PATTERN: Final[re.Pattern[str]] = re.compile(r"^\d{4}-\d{2}-\d{2}$")


def binary_date(date: str) -> str:
    """
    Return the binary representation of the year, month, and day components.

    Args:
        date: An ISO-8601 date string in the form YYYY-MM-DD.

    Returns:
        The converted date with each component rendered in base 2.

    Raises:
        ValueError: If *date* is not a well-formed ISO-8601 date.
    """
    if DATE_PATTERN.fullmatch(date) is None:
        msg = f"Invalid ISO date: {date!r}"
        raise ValueError(msg)
    year_text, month_text, day_text = date.split("-")
    year = int(year_text, 10)
    month = int(month_text, 10)
    day = int(day_text, 10)
    return f"{year:b}-{month:b}-{day:b}"


class BinaryDateExamples(unittest.TestCase):
    """Unit tests using the official examples."""

    def test_example_1(self) -> None:
        self.assertEqual(binary_date("2025-07-26"), "11111101001-111-11010")

    def test_example_2(self) -> None:
        self.assertEqual(binary_date("2000-02-02"), "11111010000-10-10")

    def test_example_3(self) -> None:
        self.assertEqual(binary_date("2024-12-31"), "11111101000-1100-11111")


if __name__ == "__main__":
    unittest.main()
