#!/usr/bin/env python3
"""
Perl Weekly Challenge 097 - Task 2: Binary Substrings

You are given a binary string B and an integer S.

Split B into substrings of size S and compute the minimum number of bit flips
required to make all substrings identical.
"""

from __future__ import annotations

from typing import Sequence


def min_flips_to_equal_substrings(binary: str, size: int) -> int:
    """Return the minimum flips to make all length-`size` chunks equal."""
    if size <= 0:
        raise ValueError("size must be positive")
    if len(binary) % size != 0:
        raise ValueError("binary length must be a multiple of size")

    chunks = [binary[i : i + size] for i in range(0, len(binary), size)]
    flips = 0
    for pos in range(size):
        ones = sum(1 for chunk in chunks if chunk[pos] == "1")
        flips += min(ones, len(chunks) - ones)
    return flips


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <B> <S>")
    print(min_flips_to_equal_substrings(argv[0], int(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge097Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(min_flips_to_equal_substrings("101100101", 3), 1)

        def test_example_2(self) -> None:
            self.assertEqual(min_flips_to_equal_substrings("10110111", 4), 2)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge097Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

