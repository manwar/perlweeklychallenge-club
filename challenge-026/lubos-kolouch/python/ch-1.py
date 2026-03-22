#!/usr/bin/env python3
"""Challenge 026 - Task 1: Stones and Jewels.

Accept two strings, called "stones" and "jewels". Print the count of
alphabetic characters from jewels that are found in stones.

The comparison is case-sensitive.
"""

from __future__ import annotations

import sys


def count_matching_letters(stones: str, jewels: str) -> int:
    """Count how many characters in jewels are present in stones."""
    stone_set = set(stones)
    return sum(1 for ch in jewels if ch in stone_set)


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) != 3:
        print(f"Usage: {argv[0]} STONES JEWELS")
        return 1

    stones, jewels = argv[1], argv[2]
    print(count_matching_letters(stones, jewels))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
