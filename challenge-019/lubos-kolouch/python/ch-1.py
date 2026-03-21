#!/usr/bin/env python3
"""
Challenge 019 - Task 1: Five Weekends

Write a script to display months from the year 1900 to 2019 where you find
5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

A month has 5 weekends if it has 31 days and the 31st falls on a Sunday.
This is because 4 weeks are 28 days, to have 5 weekends we need
additional 3 days (29, 30, 31), therefore the 31st must be a Sunday.
"""

import datetime


def has_five_weekends(year: int, month: int) -> bool:
    """
    Check if a given month has 5 weekends (5 Fridays, Saturdays, and Sundays).

    Args:
        year: The year to check
        month: The month to check (1-12)

    Returns:
        True if the month has 5 weekends, False otherwise
    """
    # A month has 5 weekends only if it has 31 days and the 31st is a Sunday
    if month not in [1, 3, 5, 7, 8, 10, 12]:  # Months with 31 days
        return False

    # Check if the 31st day is a Sunday (weekday() returns 7 for Sunday)
    return datetime.date(year, month, 31).weekday() == 6


def find_five_weekend_months(
    start_year: int = 1900, end_year: int = 2019
) -> list[tuple[int, int]]:
    """
    Find all months with 5 weekends in the given year range.

    Args:
        start_year: Start of the year range (inclusive)
        end_year: End of the year range (inclusive)

    Returns:
        List of tuples (year, month) for months with 5 weekends
    """
    result = []
    for year in range(start_year, end_year + 1):
        for month in range(1, 13):
            if has_five_weekends(year, month):
                result.append((year, month))
    return result


def main():
    """Main function to display months with 5 weekends from 1900 to 2019."""
    result = find_five_weekend_months(1900, 2019)

    for year, month in result:
        print(f"{year:04d}-{month:02d}")


if __name__ == "__main__":
    main()
