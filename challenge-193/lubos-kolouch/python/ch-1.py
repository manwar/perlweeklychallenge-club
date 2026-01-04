#!/usr/bin/env python3
"""Binary String - Perl Weekly Challenge 193 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def binary_strings(n: int) -> list[str]:
    """Return all length-n binary strings."""
    if n <= 0:
        raise ValueError("Expected n > 0")
    return [format(x, f"0{n}b") for x in range(2**n)]


class BinaryStringExamples(unittest.TestCase):
    """Example-based tests from the specification (order not significant)."""

    def test_example_1(self) -> None:
        self.assertEqual(sorted(binary_strings(2)), sorted(["00", "11", "01", "10"]))

    def test_example_2(self) -> None:
        self.assertEqual(
            sorted(binary_strings(3)),
            sorted(["000", "001", "010", "100", "111", "110", "101", "011"]),
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <n>")
    n = int(args[0])
    out = binary_strings(n)
    print(f"Input:  $n = {n}")
    print(f"Output: {', '.join(out)}")


if __name__ == "__main__":
    main()

