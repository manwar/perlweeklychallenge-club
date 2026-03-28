#!/usr/bin/env python3
"""Challenge 030 - Task 1: Sunday Christmas.

List years between 2019 and 2100 where Christmas Day (25 Dec) is Sunday.
"""

from __future__ import annotations

import datetime as dt


def sunday_christmas_years(start: int = 2019, end: int = 2100) -> list[int]:
    """Return years in the given range where 25 December is Sunday."""
    return [year for year in range(start, end + 1) if dt.date(year, 12, 25).isoweekday() == 7]


def main() -> int:
    """Print matching years as a comma-separated list."""
    print(*sunday_christmas_years(), sep=", ")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
