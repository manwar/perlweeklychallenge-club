#!/usr/bin/env python3
"""
Perl Weekly Challenge 134 - Task 1: Pandigital Numbers

Generate the first 5 pandigital numbers in base 10.

A pandigital number in base 10 contains each digit 0..9 at least once.
The smallest such numbers are permutations of all digits 0..9 with a non-zero
leading digit. We generate them in increasing order.
"""

from __future__ import annotations

import itertools
from typing import List, Sequence


def first_pandigital_numbers(count: int = 5) -> List[int]:
    """Return the first `count` pandigital numbers in base 10."""
    if count <= 0:
        raise ValueError("count must be positive")

    digits = "0123456789"
    out: List[int] = []

    for perm in itertools.permutations(digits):
        if perm[0] == "0":
            continue
        out.append(int("".join(perm)))
        if len(out) == count:
            break

    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <count>")
    print(first_pandigital_numbers(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge134Task1(unittest.TestCase):
        def test_generates_5_pandigitals(self) -> None:
            nums = first_pandigital_numbers(5)
            self.assertEqual(len(nums), 5)
            self.assertTrue(all(len(str(n)) == 10 for n in nums))
            self.assertTrue(all(set(str(n)) == set("0123456789") for n in nums))
            self.assertTrue(all(str(n)[0] != "0" for n in nums))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge134Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
