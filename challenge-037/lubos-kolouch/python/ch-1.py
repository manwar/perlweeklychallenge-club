#!/usr/bin/env python3
"""
Perl Weekly Challenge 037 - Task 1

Calculate the number of weekdays (Mon-Fri) in each month of year 2019.
"""

from __future__ import annotations

from datetime import date, timedelta
from typing import Dict, Sequence


def weekday_counts_2019() -> Dict[str, int]:
    """Return weekday counts for each month abbreviation in 2019."""
    out: Dict[str, int] = {
        "Jan": 0,
        "Feb": 0,
        "Mar": 0,
        "Apr": 0,
        "May": 0,
        "Jun": 0,
        "Jul": 0,
        "Aug": 0,
        "Sep": 0,
        "Oct": 0,
        "Nov": 0,
        "Dec": 0,
    }

    d = date(2019, 1, 1)
    one_day = timedelta(days=1)
    while d.year == 2019:
        if d.weekday() < 5:  # Mon=0 .. Fri=4
            out[d.strftime("%b")] += 1
        d += one_day

    return out


def _run_cli(argv: Sequence[str]) -> None:
    if argv:
        raise SystemExit(f"Usage: {__file__}")
    _run_tests()
    counts = weekday_counts_2019()
    for m in ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"):
        print(f"{m}: {counts[m]} days")


def _run_tests() -> None:
    import unittest

    class TestChallenge037Task1(unittest.TestCase):
        def test_official_counts(self) -> None:
            self.assertEqual(
                weekday_counts_2019(),
                {
                    "Jan": 23,
                    "Feb": 20,
                    "Mar": 21,
                    "Apr": 22,
                    "May": 23,
                    "Jun": 20,
                    "Jul": 23,
                    "Aug": 22,
                    "Sep": 21,
                    "Oct": 23,
                    "Nov": 21,
                    "Dec": 22,
                },
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge037Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

