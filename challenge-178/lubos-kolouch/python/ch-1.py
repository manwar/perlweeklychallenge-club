#!/usr/bin/env python3
"""Quater-imaginary Base - Perl Weekly Challenge 178 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def _to_base_neg4(n: int) -> list[int]:
    if n == 0:
        return [0]
    digits: list[int] = []
    while n != 0:
        r = n % 4
        digits.append(r)
        n = (n - r) // -4
    return list(reversed(digits))


def to_quater_imaginary(n: int) -> str:
    """Convert base-10 integer to base 2i (quater-imaginary) representation."""
    digits = _to_base_neg4(n)
    return "0".join(str(d) for d in digits)


def from_quater_imaginary(s: str) -> int:
    """Convert base 2i representation to a base-10 integer (real results only)."""
    if not s or any(ch not in "0123" for ch in s):
        raise ValueError("Expected digits 0..3 only")

    re = 0
    im = 0
    for ch in s:
        digit = int(ch)
        re, im = -2 * im, 2 * re
        re += digit
    if im != 0:
        raise ValueError("Not a real number")
    return re


class QuaterImaginaryExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_to(self) -> None:
        self.assertEqual(to_quater_imaginary(4), "10300")

    def test_example_from(self) -> None:
        self.assertEqual(from_quater_imaginary("10300"), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <integer|quater-imaginary>")
    arg = args[0]
    if arg.lstrip("-").isdigit():
        n = int(arg)
        print(f"Input:  {n}")
        print(f"Output: {to_quater_imaginary(n)}")
    else:
        print(f"Input:  {arg}")
        print(f"Output: {from_quater_imaginary(arg)}")


if __name__ == "__main__":
    main()

