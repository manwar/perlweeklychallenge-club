#!/usr/bin/env python3
"""Find K-Beauty - Perl Weekly Challenge 375 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def k_beauty(num: int, k: int) -> int:
    """Return the K-Beauty of a given integer number."""
    num_str = str(num)
    count = 0
    for i in range(len(num_str) - k + 1):
        substring = num_str[i : i + k]
        val = int(substring)
        if val != 0 and num % val == 0:
            count += 1
    return count


class KBeautyExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(k_beauty(240, 2), 2)

    def test_example_2(self) -> None:
        self.assertEqual(k_beauty(430043, 2), 2)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
