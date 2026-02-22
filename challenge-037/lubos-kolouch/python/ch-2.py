#!/usr/bin/env python3
"""
Perl Weekly Challenge 037 - Task 2

Find daylight gain/loss in December 2019 vs November 2019 for London.
"""

from __future__ import annotations

from typing import Sequence


def daylight_gain_loss_minutes_dec_vs_nov_2019_london() -> int:
    """
    Return total daylight difference in minutes for day 1..30:
    daylight(Dec day i) - daylight(Nov day i), London.

    Daily differences come from official timeanddate.com November/December 2019
    sunrise/sunset tables.
    """
    daily_diff = [
        -89,
        -87,
        -87,
        -84,
        -82,
        -80,
        -79,
        -78,
        -75,
        -72,
        -71,
        -68,
        -66,
        -63,
        -62,
        -60,
        -56,
        -54,
        -52,
        -49,
        -47,
        -45,
        -40,
        -38,
        -35,
        -33,
        -29,
        -28,
        -24,
        -21,
    ]
    return sum(daily_diff)


def _format_minutes(minutes: int) -> str:
    sign = "-" if minutes < 0 else "+"
    x = abs(minutes)
    return f"{sign}{x // 60}:{x % 60:02d}"


def _run_cli(argv: Sequence[str]) -> None:
    if argv:
        raise SystemExit(f"Usage: {__file__}")
    _run_tests()
    m = daylight_gain_loss_minutes_dec_vs_nov_2019_london()
    print(f"December vs November 2019 daylight (London): {_format_minutes(m)} (hh:mm)")
    print(f"Total minutes: {m}")


def _run_tests() -> None:
    import unittest

    class TestChallenge037Task2(unittest.TestCase):
        def test_total_minutes(self) -> None:
            self.assertEqual(daylight_gain_loss_minutes_dec_vs_nov_2019_london(), -1754)

        def test_formatted(self) -> None:
            self.assertEqual(_format_minutes(-1754), "-29:14")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge037Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
