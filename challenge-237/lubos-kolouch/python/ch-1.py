#!/usr/bin/env python
# -*- coding: utf-8 -*-

import datetime
import unittest


def find_day(year: int, month: int, weekday_of_month: int, day_of_week: int) -> int:
    """
    Find the nth occurrence of a day in a given month and year.

    Parameters:
    year (int): The year
    month (int): The month
    weekday_of_month (int): The nth occurrence of the weekday
    day_of_week (int): The day of the week (1: Monday, ..., 7: Sunday)

    Returns:
    int: The day of the month, or 0 if it doesn't exist
    """
    # Find the first day of the month
    first_day = datetime.date(year, month, 1)

    # Calculate the difference between the first day of the month and the desired day of the week
    days_diff = (day_of_week - first_day.weekday() - 1) % 7

    # Find the first occurrence of the desired day
    first_occurrence = first_day + datetime.timedelta(days=days_diff)

    # Find the nth occurrence
    nth_occurrence = first_occurrence + \
        datetime.timedelta(days=(weekday_of_month - 1) * 7)

    # Check if the resulting date is in the same month
    if nth_occurrence.month == month:
        return nth_occurrence.day

    return 0


class TestFindDay(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(find_day(2024, 4, 3, 2), 16)
        self.assertEqual(find_day(2025, 10, 2, 4), 9)
        self.assertEqual(find_day(2026, 8, 5, 3), 0)


if __name__ == '__main__':
    unittest.main()
