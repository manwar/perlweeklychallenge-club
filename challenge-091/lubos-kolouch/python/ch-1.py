#!/usr/bin/env python3
"""
Perl Weekly Challenge 091 - Task 1: Count Number

Given a positive number N, "count number and display as you read it":
emit the run-length encoding of N's digits (count followed by digit).
"""

from __future__ import annotations

from typing import Sequence, Union


def as_we_read(n: Union[int, str]) -> str:
    """Return the run-length encoding of digits in `n` as a string."""
    s = str(n)
    if not s.isdigit() or s.startswith("-"):
        raise ValueError("n must be a positive integer (digits only)")

    if not s:
        return ""

    out: list[str] = []
    last = s[0]
    count = 1
    for ch in s[1:]:
        if ch == last:
            count += 1
        else:
            out.append(f"{count}{last}")
            last = ch
            count = 1
    out.append(f"{count}{last}")
    return "".join(out)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(as_we_read(argv[0]))


def _run_tests() -> None:
    import unittest

    class TestChallenge091Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(as_we_read(1122234), "21321314")

        def test_example_2(self) -> None:
            self.assertEqual(as_we_read(2333445), "12332415")

        def test_example_3(self) -> None:
            self.assertEqual(as_we_read(12345), "1112131415")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge091Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

