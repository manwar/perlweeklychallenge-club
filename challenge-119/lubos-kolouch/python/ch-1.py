#!/usr/bin/env python3
"""
Perl Weekly Challenge 119 - Task 1: Swap Nibbles

Given a positive integer N (<= 255), swap the two nibbles of its 8-bit binary
representation and return the decimal value.
"""

from __future__ import annotations

from typing import Sequence


def swap_nibbles(n: int) -> int:
    """Return n with its high/low 4-bit nibbles swapped."""
    if n < 0 or n > 255:
        raise ValueError("n must be in range 0..255")
    return ((n & 0x0F) << 4) | ((n & 0xF0) >> 4)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(swap_nibbles(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge119Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(swap_nibbles(101), 86)

        def test_example_2(self) -> None:
            self.assertEqual(swap_nibbles(18), 33)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge119Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

