#!/usr/bin/env python3
"""
Task: Day of the Year (Weekly Challenge 326)

Return the day-of-year number for a date in YYYY-MM-DD format.
"""
from __future__ import annotations

import unittest
from typing import Tuple


def is_leap(year: int) -> bool:
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)


def day_of_year(date: str) -> int:
    year, month, day = (int(part) for part in date.split("-"))
    month_lengths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if is_leap(year):
        month_lengths[2] = 29
    return day + sum(month_lengths[1:month])


class DayOfYearTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(day_of_year("2025-02-02"), 33)
        self.assertEqual(day_of_year("2025-04-10"), 100)
        self.assertEqual(day_of_year("2025-09-07"), 250)


if __name__ == "__main__":
    unittest.main()
