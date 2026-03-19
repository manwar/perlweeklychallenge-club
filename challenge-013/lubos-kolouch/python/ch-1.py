#!/usr/bin/env python3
"""
Challenge 013, Task 1: Last Fridays of every month

Given a year, print the date of the last Friday of every month.

Example output for year 2019:
    2019/01/25
    2019/02/22
    2019/03/29
    ...

Author: Lubos Kolouch
"""

import calendar
import unittest


def get_last_friday_of_month(year: int, month: int) -> str:
    """
    Get the date of the last Friday of a given month and year.

    Args:
        year: The year (e.g., 2019)
        month: The month (1-12)

    Returns:
        Formatted string in YYYY/MM/DD format

    Examples:
        >>> get_last_friday_of_month(2019, 1)
        '2019/01/25'
        >>> get_last_friday_of_month(2019, 2)
        '2019/02/22'
    """
    # Get the last day of the month
    last_day = calendar.monthrange(year, month)[1]

    # Get the weekday of the last day (0=Monday, 6=Sunday)
    last_day_weekday = calendar.weekday(year, month, last_day)

    # Calculate days to subtract to reach Friday (weekday 4)
    days_to_friday = (last_day_weekday - 4) % 7
    last_friday_day = last_day - days_to_friday

    return f"{year}/{month:02d}/{last_friday_day:02d}"


def get_all_last_fridays(year: int) -> list[str]:
    """
    Get the dates of the last Friday of every month in a given year.

    Args:
        year: The year (e.g., 2019)

    Returns:
        List of formatted strings in YYYY/MM/DD format

    Examples:
        >>> get_all_last_fridays(2019)[:3]
        ['2019/01/25', '2019/02/22', '2019/03/29']
    """
    return [get_last_friday_of_month(year, month) for month in range(1, 13)]


def main() -> None:
    """Main function to print last Fridays for year 2019."""
    for date_str in get_all_last_fridays(2019):
        print(date_str)


if __name__ == "__main__":
    main()


class TestLastFridays(unittest.TestCase):
    """Unit tests for last Fridays calculation."""

    def test_last_friday_january_2019(self):
        """Test last Friday of January 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 1), "2019/01/25")

    def test_last_friday_february_2019(self):
        """Test last Friday of February 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 2), "2019/02/22")

    def test_last_friday_march_2019(self):
        """Test last Friday of March 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 3), "2019/03/29")

    def test_last_friday_april_2019(self):
        """Test last Friday of April 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 4), "2019/04/26")

    def test_last_friday_may_2019(self):
        """Test last Friday of May 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 5), "2019/05/31")

    def test_last_friday_june_2019(self):
        """Test last Friday of June 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 6), "2019/06/28")

    def test_last_friday_july_2019(self):
        """Test last Friday of July 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 7), "2019/07/26")

    def test_last_friday_august_2019(self):
        """Test last Friday of August 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 8), "2019/08/30")

    def test_last_friday_september_2019(self):
        """Test last Friday of September 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 9), "2019/09/27")

    def test_last_friday_october_2019(self):
        """Test last Friday of October 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 10), "2019/10/25")

    def test_last_friday_november_2019(self):
        """Test last Friday of November 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 11), "2019/11/29")

    def test_last_friday_december_2019(self):
        """Test last Friday of December 2019."""
        self.assertEqual(get_last_friday_of_month(2019, 12), "2019/12/27")

    def test_all_last_fridays_2019(self):
        """Test all last Fridays for year 2019."""
        expected = [
            "2019/01/25",
            "2019/02/22",
            "2019/03/29",
            "2019/04/26",
            "2019/05/31",
            "2019/06/28",
            "2019/07/26",
            "2019/08/30",
            "2019/09/27",
            "2019/10/25",
            "2019/11/29",
            "2019/12/27",
        ]
        self.assertEqual(get_all_last_fridays(2019), expected)


if __name__ == "__main__":
    unittest.main()
