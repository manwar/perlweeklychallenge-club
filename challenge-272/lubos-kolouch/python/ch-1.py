#!/usr/bin/env python3
"""Defang IP Address - Perl Weekly Challenge 272 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def defang_ip(ip: str) -> str:
    """Return defanged IPv4 string by replacing '.' with '[.]'."""
    return ip.replace(".", "[.]")


class DefangIPExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(defang_ip("1.1.1.1"), "1[.]1[.]1[.]1")

    def test_example_2(self) -> None:
        self.assertEqual(defang_ip("255.101.1.0"), "255[.]101[.]1[.]0")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <ip>")
    ip = args[0]
    print(f'Input:  $ip = "{ip}"')
    print(f'Output: "{defang_ip(ip)}"')


if __name__ == "__main__":
    main()

