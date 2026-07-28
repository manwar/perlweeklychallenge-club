#!/usr/bin/env python3
"""Special Binary Substrings - Perl Weekly Challenge 384 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def special_binary_substrings(binary: str) -> list[str]:
    """Find all non-empty substrings with same number of 0s and 1s grouped consecutively."""
    length = len(binary)
    matches = set()

    for k in range(1, length // 2 + 1):
        pattern1 = "0" * k + "1" * k
        pattern2 = "1" * k + "0" * k

        if pattern1 in binary:
            matches.add(pattern1)
        if pattern2 in binary:
            matches.add(pattern2)

    return sorted(list(matches))


class SpecialBinarySubstringsExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(special_binary_substrings("0101"), ["01", "10"])

    def test_example_2(self) -> None:
        self.assertEqual(special_binary_substrings("000111"), ["000111", "0011", "01"])

    def test_example_3(self) -> None:
        self.assertEqual(special_binary_substrings("000011"), ["0011", "01"])

    def test_example_4(self) -> None:
        self.assertEqual(
            special_binary_substrings("10011100"),
            ["0011", "01", "10", "1100"],
        )

    def test_example_5(self) -> None:
        self.assertEqual(special_binary_substrings("00000"), [])


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
