#!/usr/bin/env python3
"""Group Digit Sum - Perl Weekly Challenge 311 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def _sum_digits(chunk: str) -> int:
    return sum(int(ch) for ch in chunk)


def group_digit_sum(text: str, size: int) -> str:
    """
    Repeatedly sum digits in consecutive groups of ``size`` and concatenate sums.

    Stop once the new string length is <= ``size``.
    """
    if size <= 0:
        raise ValueError("Expected size > 0")
    if not text.isdigit():
        raise ValueError("Expected digits only")

    while len(text) > size:
        parts = [text[idx : idx + size] for idx in range(0, len(text), size)]
        text = "".join(str(_sum_digits(part)) for part in parts)
    return text


class GroupDigitSumExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(group_digit_sum("111122333", 3), "359")

    def test_example_2(self) -> None:
        self.assertEqual(group_digit_sum("1222312", 2), "76")

    def test_example_3(self) -> None:
        self.assertEqual(group_digit_sum("100012121001", 4), "162")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <digits> <int>")

    text = args[0]
    size = int(args[1])
    result = group_digit_sum(text, size)
    print(f'Input: $str = "{text}", $int = {size}')
    print(f'Output: "{result}"')


if __name__ == "__main__":
    main()
