#!/usr/bin/env python3
"""Challenge 030 - Task 2: Series of 3 positive numbers.

Print all strictly increasing triples of positive integers that sum to a
requested value and contain at least one even number.
"""

from __future__ import annotations

import sys


def series(total: int) -> list[tuple[int, int, int]]:
    """Return all triples (i, j, k) with i < j < k, sum == total, and any even."""
    result: list[tuple[int, int, int]] = []
    for i in range(1, total + 1):
        for j in range(i + 1, total + 1):
            k = total - i - j
            if k <= j:
                continue
            if any(n % 2 == 0 for n in (i, j, k)):
                result.append((i, j, k))
    return result


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    total = int(argv[1]) if len(argv) > 1 else 12
    for i, j, k in series(total):
        print(f"{i},{j},{k}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
