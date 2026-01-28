#!/usr/bin/env python3
"""
Perl Weekly Challenge 358 - Task 2: Encrypted String

Encrypt a string by shifting each character by `n` positions in the alphabet,
wrapping around as needed (Caesar cipher).

Examples assume lowercase letters; this implementation shifts both lowercase and
uppercase letters and leaves non-letters unchanged.
"""

from __future__ import annotations

from typing import Sequence


def encrypt(s: str, n: int) -> str:
    """Return encrypted string by shifting letters by n (mod 26)."""
    k = n % 26
    out_chars: list[str] = []
    for ch in s:
        if "a" <= ch <= "z":
            out_chars.append(chr(ord("a") + ((ord(ch) - ord("a") + k) % 26)))
        elif "A" <= ch <= "Z":
            out_chars.append(chr(ord("A") + ((ord(ch) - ord("A") + k) % 26)))
        else:
            out_chars.append(ch)
    return "".join(out_chars)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <str> <int>")
    print(encrypt(argv[0], int(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge358Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(encrypt("abc", 1), "bcd")

        def test_example_2(self) -> None:
            self.assertEqual(encrypt("xyz", 2), "zab")

        def test_example_3(self) -> None:
            self.assertEqual(encrypt("abc", 27), "bcd")

        def test_example_4(self) -> None:
            self.assertEqual(encrypt("hello", 5), "mjqqt")

        def test_example_5(self) -> None:
            self.assertEqual(encrypt("perl", 26), "perl")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge358Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

