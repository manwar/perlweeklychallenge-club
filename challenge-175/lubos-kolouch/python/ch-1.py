#!/usr/bin/env python3
"""Last Sunday - Perl Weekly Challenge 175 task 1."""

from __future__ import annotations

from collections.abc import Sequence
from datetime import date, timedelta
import sys
import unittest


def last_sundays(year: int) -> list[str]:
    """Return last Sunday of each month in the given year (YYYY-MM-DD)."""
    if year <= 0:
        raise ValueError("Expected a positive year")

    out: list[str] = []
    for month in range(1, 13):
        if month == 12:
            first_next = date(year + 1, 1, 1)
        else:
            first_next = date(year, month + 1, 1)

        d = first_next - timedelta(days=1)
        while d.weekday() != 6:  # Monday=0 .. Sunday=6
            d -= timedelta(days=1)
        out.append(d.isoformat())
    return out


class LastSundayExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_2022(self) -> None:
        self.assertEqual(
            last_sundays(2022),
            [
                "2022-01-30",
                "2022-02-27",
                "2022-03-27",
                "2022-04-24",
                "2022-05-29",
                "2022-06-26",
                "2022-07-31",
                "2022-08-28",
                "2022-09-25",
                "2022-10-30",
                "2022-11-27",
                "2022-12-25",
            ],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <year>")
    year = int(args[0])
    for line in last_sundays(year):
        print(line)


if __name__ == "__main__":
    main()

