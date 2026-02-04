#!/usr/bin/env python3
"""
Perl Weekly Challenge 104 - Task 1: FUSC Sequence

Generate the first 50 members of the FUSC sequence:

  fusc(0) = 0
  fusc(1) = 1
  for n > 1:
    if n is even: fusc(n) = fusc(n/2)
    if n is odd:  fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
"""

from __future__ import annotations

from typing import List, Sequence


def fusc_first(count: int) -> List[int]:
    """Return the first `count` values of the FUSC sequence."""
    if count < 0:
        raise ValueError("count must be >= 0")
    if count == 0:
        return []
    if count == 1:
        return [0]

    values = [0] * count
    values[0] = 0
    values[1] = 1

    for n in range(2, count):
        if n % 2 == 0:
            values[n] = values[n // 2]
        else:
            values[n] = values[(n - 1) // 2] + values[(n + 1) // 2]

    return values


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge104Task1(unittest.TestCase):
        def test_first_5(self) -> None:
            self.assertEqual(fusc_first(5), [0, 1, 1, 2, 1])

        def test_first_50(self) -> None:
            self.assertEqual(
                fusc_first(50),
                [
                    0,
                    1,
                    1,
                    2,
                    1,
                    3,
                    2,
                    3,
                    1,
                    4,
                    3,
                    5,
                    2,
                    5,
                    3,
                    4,
                    1,
                    5,
                    4,
                    7,
                    3,
                    8,
                    5,
                    7,
                    2,
                    7,
                    5,
                    8,
                    3,
                    7,
                    4,
                    5,
                    1,
                    6,
                    5,
                    9,
                    4,
                    11,
                    7,
                    10,
                    3,
                    11,
                    8,
                    13,
                    5,
                    12,
                    7,
                    9,
                    2,
                    9,
                ],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge104Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

