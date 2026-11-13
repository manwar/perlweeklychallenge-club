#!/usr/bin/env python3
"""Banking Day Offset - Perl Weekly Challenge 259 Task 1."""

from __future__ import annotations

from datetime import datetime, timedelta
import unittest


def banking_day_offset(
    start_date: str, offset: int, bank_holidays: list[str] | None = None
) -> str:
    """Calculate the target date after advancing a number of banking days.

    Skips weekends (Saturday, Sunday) and any bank holidays listed.

    Args:
        start_date: Starting date in YYYY-MM-DD format.
        offset: Number of banking days to advance.
        bank_holidays: Optional list of bank holidays in YYYY-MM-DD format.

    Returns:
        The resulting date in YYYY-MM-DD format.
    """
    holidays = set(bank_holidays or [])
    current = datetime.strptime(start_date, "%Y-%m-%d").date()

    remaining = offset
    one_day = timedelta(days=1)
    while remaining > 0:
        current += one_day
        # weekday(): Monday is 0 and Sunday is 6
        if current.weekday() >= 5:
            continue
        if current.isoformat() in holidays:
            continue
        remaining -= 1

    return current.isoformat()


class TestBankingDayOffset(unittest.TestCase):
    """Unit tests for banking_day_offset."""

    def test_example_1(self) -> None:
        """Test Example 1: with a bank holiday falling on Tuesday."""
        self.assertEqual(
            banking_day_offset("2018-06-28", 3, ["2018-07-03"]), "2018-07-04"
        )

    def test_example_2(self) -> None:
        """Test Example 2: without bank holidays."""
        self.assertEqual(banking_day_offset("2018-06-28", 3), "2018-07-03")

    def test_weekend_skip(self) -> None:
        """Test advancing 1 banking day from Friday lands on Monday."""
        self.assertEqual(banking_day_offset("2018-06-29", 1), "2018-07-02")


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
