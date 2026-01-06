#!/usr/bin/env python3
"""Zip List - Perl Weekly Challenge 186 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def zip_list(a: Sequence[str], b: Sequence[str]) -> list[str]:
    """Merge two equal-length sequences by alternating elements."""
    if len(a) != len(b):
        raise ValueError("Expected lists of the same size")
    out: list[str] = []
    for x, y in zip(a, b):
        out.extend((x, y))
    return out


class ZipListExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_ab(self) -> None:
        self.assertEqual(zip_list(("1", "2", "3"), ("a", "b", "c")), ["1", "a", "2", "b", "3", "c"])

    def test_example_ba(self) -> None:
        self.assertEqual(zip_list(("a", "b", "c"), ("1", "2", "3")), ["a", "1", "b", "2", "c", "3"])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface.

    Usage: python3 ch-1.py <a...> -- <b...>
    """
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if "--" not in args:
        raise SystemExit("Usage: python3 ch-1.py <a...> -- <b...>")
    sep = args.index("--")
    if sep == 0 or sep == len(args) - 1:
        raise SystemExit("Usage: python3 ch-1.py <a...> -- <b...>")
    a = args[:sep]
    b = args[sep + 1 :]
    out = zip_list(a, b)
    print(f"Output: ({', '.join(out)})")


if __name__ == "__main__":
    main()

