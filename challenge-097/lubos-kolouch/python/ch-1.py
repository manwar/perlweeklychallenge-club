#!/usr/bin/env python3
"""
Perl Weekly Challenge 097 - Task 1: Caesar Cipher

You are given a string S containing only letters A..Z and spaces, and a number N.
Encrypt S using Caesar cipher with a left shift of N.
"""

from __future__ import annotations

from typing import Sequence


def caesar_left_shift(text: str, shift: int) -> str:
    """Return `text` encrypted by a left shift of `shift` over A..Z."""
    n = shift % 26
    out: list[str] = []
    for ch in text:
        if "A" <= ch <= "Z":
            idx = ord(ch) - ord("A")
            out.append(chr(ord("A") + (idx - n) % 26))
        else:
            out.append(ch)
    return "".join(out)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <S> <N>")
    print(caesar_left_shift(argv[0], int(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge097Task1(unittest.TestCase):
        def test_example(self) -> None:
            self.assertEqual(
                caesar_left_shift("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", 3),
                "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD",
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge097Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

