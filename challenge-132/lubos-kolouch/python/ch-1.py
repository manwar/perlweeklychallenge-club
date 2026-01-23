#!/usr/bin/env python3
"""
Perl Weekly Challenge 132 - Task 1: Mirror Dates

Given a date (yyyy/mm/dd), find the mirror dates assuming "today" is
2021/09/22 (as per the challenge statement examples).

Let delta = today - birth_date (in days). Then:
  - previous_mirror = birth_date - delta
  - next_mirror     = today + delta
"""

from __future__ import annotations

from datetime import date, timedelta
from typing import Sequence, Tuple


def _parse_ymd(s: str) -> date:
    y, m, d = (int(x) for x in s.split("/"))
    return date(y, m, d)


def mirror_dates(birth_ymd: str, today_ymd: str = "2021/09/22") -> Tuple[str, str]:
    """Return the (previous, next) mirror dates as yyyy/mm/dd strings."""
    birth = _parse_ymd(birth_ymd)
    today = _parse_ymd(today_ymd)
    delta: timedelta = today - birth
    prev = birth - delta
    nxt = today + delta
    return (prev.strftime("%Y/%m/%d"), nxt.strftime("%Y/%m/%d"))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) not in (1, 2):
        raise SystemExit(f"Usage: {__file__} <birth_yyyy/mm/dd> [today_yyyy/mm/dd]")
    birth = argv[0]
    today = argv[1] if len(argv) == 2 else "2021/09/22"
    prev, nxt = mirror_dates(birth, today)
    print(f"{prev}, {nxt}")


def _run_tests() -> None:
    import unittest

    class TestChallenge132Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(mirror_dates("2021/09/18"), ("2021/09/14", "2021/09/26"))

        def test_example_2(self) -> None:
            self.assertEqual(mirror_dates("1975/10/10"), ("1929/10/27", "2067/09/05"))

        def test_example_3(self) -> None:
            self.assertEqual(mirror_dates("1967/02/14"), ("1912/07/08", "2076/04/30"))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge132Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

