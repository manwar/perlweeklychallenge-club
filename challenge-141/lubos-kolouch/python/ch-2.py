#!/usr/bin/env python3
"""
Perl Weekly Challenge 141 - Task 2: Like Numbers

Given positive integers m and n, count how many integers can be created from the
digits of m such that:
  - Digits keep their original order (subsequence).
  - No digit repeats (unique digits).
  - The created integer uses at most (len(m_digits) - 1) digits.
  - The created integer is divisible by n.
"""

from __future__ import annotations

from typing import List, Sequence


def unique_digits_in_order(m: int) -> List[int]:
    """Return unique digits of m in the order of first appearance."""
    if m <= 0:
        raise ValueError("m must be a positive integer")
    seen = set()
    out: List[int] = []
    for ch in str(m):
        d = int(ch)
        if d not in seen:
            seen.add(d)
            out.append(d)
    return out


def like_numbers_count(m: int, n: int) -> int:
    """Count integers built from digits of m (as subsequences) divisible by n."""
    if m <= 0:
        raise ValueError("m must be a positive integer")
    if n <= 0:
        raise ValueError("n must be a positive integer")

    digits = unique_digits_in_order(m)
    max_len = len(digits) - 1
    if max_len <= 0:
        return 0

    count = 0

    def rec(index: int, length: int, mod: int) -> None:
        nonlocal count
        if index == len(digits):
            if 1 <= length <= max_len and mod == 0:
                count += 1
            return

        # Skip this digit
        rec(index + 1, length, mod)

        # Take this digit (only if we won't exceed max_len)
        if length < max_len:
            rec(index + 1, length + 1, (mod * 10 + digits[index]) % n)

    rec(0, 0, 0)
    return count


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <m> <n>")

    m = int(argv[0])
    n = int(argv[1])
    print(like_numbers_count(m, n))


def _run_tests() -> None:
    import unittest

    class TestChallenge141Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(like_numbers_count(1234, 2), 9)

        def test_example_2(self) -> None:
            self.assertEqual(like_numbers_count(768, 4), 3)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge141Task2)
    runner = unittest.TextTestRunner()
    result = runner.run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
