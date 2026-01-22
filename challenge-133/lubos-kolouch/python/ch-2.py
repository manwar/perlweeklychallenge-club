#!/usr/bin/env python3
"""
Perl Weekly Challenge 133 - Task 2: Smith Numbers

Generate the first N Smith numbers in base 10.

A Smith number is a composite number for which the sum of its digits equals the
sum of the digits in its prime factorization (counting multiplicity).
"""

from __future__ import annotations

from typing import List, Sequence


def digit_sum(n: int) -> int:
    return sum(int(ch) for ch in str(n))


def prime_factors(n: int) -> List[int]:
    factors: List[int] = []
    x = n

    while x % 2 == 0:
        factors.append(2)
        x //= 2

    p = 3
    while p * p <= x:
        while x % p == 0:
            factors.append(p)
            x //= p
        p += 2

    if x > 1:
        factors.append(x)
    return factors


def is_composite(n: int) -> bool:
    if n < 4:
        return False
    if n % 2 == 0:
        return True
    d = 3
    while d * d <= n:
        if n % d == 0:
            return True
        d += 2
    return False


def is_smith(n: int) -> bool:
    if not is_composite(n):
        return False
    return digit_sum(n) == sum(digit_sum(p) for p in prime_factors(n))


def first_smith_numbers(count: int) -> List[int]:
    if count <= 0:
        raise ValueError("count must be positive")

    out: List[int] = []
    n = 4
    while len(out) < count:
        if is_smith(n):
            out.append(n)
        n += 1
    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <count>")
    print(first_smith_numbers(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge133Task2(unittest.TestCase):
        def test_definition_examples(self) -> None:
            self.assertTrue(is_smith(4))
            self.assertFalse(is_smith(10))

        def test_first_10_properties(self) -> None:
            nums = first_smith_numbers(10)
            self.assertEqual(len(nums), 10)
            self.assertTrue(all(is_smith(x) for x in nums))
            self.assertTrue(all(is_composite(x) for x in nums))
            self.assertEqual(nums, sorted(nums))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge133Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

