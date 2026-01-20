#!/usr/bin/env python3
"""
Perl Weekly Challenge 135 - Task 1: Middle 3-digits

Given an integer n, return the middle 3 digits if possible; otherwise return a
sensible error string as shown in the official examples.
"""

from __future__ import annotations

from typing import Sequence, Union


def middle_three_digits(n: int) -> Union[int, str]:
    """
    Return the middle 3 digits of n (ignoring sign) or an error string.

    Official example error messages:
      - 'too short' (when fewer than 3 digits)
      - 'even number of digits' (when digit count is even)
    """
    s = str(abs(n))

    if len(s) % 2 == 0:
        return "even number of digits"
    if len(s) < 3:
        return "too short"

    mid = len(s) // 2
    return int(s[mid - 1 : mid + 2])


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <n>")

    n = int(argv[0])
    print(middle_three_digits(n))


def _run_tests() -> None:
    import unittest

    class TestChallenge135Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(middle_three_digits(1234567), 345)

        def test_example_2(self) -> None:
            self.assertEqual(middle_three_digits(-123), 123)

        def test_example_3(self) -> None:
            self.assertEqual(middle_three_digits(1), "too short")

        def test_example_4(self) -> None:
            self.assertEqual(middle_three_digits(10), "even number of digits")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge135Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
