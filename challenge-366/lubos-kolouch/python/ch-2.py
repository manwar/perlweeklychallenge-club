#!/usr/bin/env python3
"""Challenge 366, Task 2: Valid Times.

Count the number of valid times matching a pattern containing '?' characters.
"""

from __future__ import annotations

import sys


def count_valid_times(time: str) -> int:
    """Return the number of valid times that match *time*."""
    if len(time) != 5 or time[2] != ":":
        raise ValueError("time must be in HH:MM form")

    target_hour = time[:2]
    target_minute = time[3:]
    count = 0

    for hour in range(24):
        hh = f"{hour:02d}"
        if all(t == "?" or t == h for t, h in zip(target_hour, hh)):
            for minute in range(60):
                mm = f"{minute:02d}"
                if all(t == "?" or t == m for t, m in zip(target_minute, mm)):
                    count += 1

    return count


def _run_examples() -> int:
    examples = [
        ("?2:34", 3),
        ("?4:?0", 12),
        ("??:??", 1440),
        ("?3:45", 3),
        ("2?:15", 4),
    ]
    for time, expected in examples:
        actual = count_valid_times(time)
        if actual != expected:
            raise AssertionError((time, actual, expected))
        print(actual)
    return 0


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) == 1:
        return _run_examples()

    print(count_valid_times(argv[1]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
