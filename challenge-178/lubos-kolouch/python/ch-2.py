#!/usr/bin/env python3
"""Business Date - Perl Weekly Challenge 178 task 2."""

from __future__ import annotations

from collections.abc import Sequence
from dataclasses import dataclass
from datetime import datetime, time, timedelta
from decimal import Decimal, ROUND_HALF_UP
import sys
import unittest


BUSINESS_START = time(9, 0)
BUSINESS_END = time(18, 0)


def _is_weekend(dt: datetime) -> bool:
    return dt.weekday() >= 5  # 5=Sat, 6=Sun


def _next_business_start(dt: datetime) -> datetime:
    while _is_weekend(dt):
        dt = datetime(dt.year, dt.month, dt.day) + timedelta(days=1)
        dt = dt.replace(hour=9, minute=0)

    start = datetime(dt.year, dt.month, dt.day, BUSINESS_START.hour, BUSINESS_START.minute)
    end = datetime(dt.year, dt.month, dt.day, BUSINESS_END.hour, BUSINESS_END.minute)

    if dt < start:
        return start
    if dt >= end:
        dt = datetime(dt.year, dt.month, dt.day) + timedelta(days=1)
        return _next_business_start(dt.replace(hour=9, minute=0))
    return dt


def _duration_to_minutes(duration_hours: str) -> int:
    minutes = (Decimal(duration_hours) * Decimal(60)).quantize(Decimal("1"), rounding=ROUND_HALF_UP)
    return int(minutes)


def business_date(timestamp: str, duration_hours: str) -> str:
    """Return timestamp after duration business hours (Mon-Fri 09:00-18:00)."""
    dt = datetime.strptime(timestamp, "%Y-%m-%d %H:%M")
    remaining = _duration_to_minutes(duration_hours)

    dt = _next_business_start(dt)
    while remaining > 0:
        dt = _next_business_start(dt)
        end = datetime(dt.year, dt.month, dt.day, BUSINESS_END.hour, BUSINESS_END.minute)
        available = int((end - dt).total_seconds() // 60)
        take = min(remaining, available)
        dt = dt + timedelta(minutes=take)
        remaining -= take
        if remaining > 0:
            dt = _next_business_start((datetime(dt.year, dt.month, dt.day) + timedelta(days=1)).replace(hour=9, minute=0))

    return dt.strftime("%Y-%m-%d %H:%M")


class BusinessDateExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(business_date("2022-08-01 10:30", "4"), "2022-08-01 14:30")

    def test_example_2(self) -> None:
        self.assertEqual(business_date("2022-08-01 17:00", "3.5"), "2022-08-02 11:30")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit('Usage: python3 ch-2.py "YYYY-MM-DD HH:MM" <duration-hours>')
    timestamp, duration = args
    print(business_date(timestamp, duration))


if __name__ == "__main__":
    main()

