#!/usr/bin/env python3
"""Disarium Numbers - Perl Weekly Challenge 174 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_disarium(n: int) -> bool:
    digits = [int(ch) for ch in str(n)]
    return sum(d ** (i + 1) for i, d in enumerate(digits)) == n


def disarium_numbers(count: int) -> list[int]:
    """Return the first `count` Disarium numbers."""
    if count <= 0:
        raise ValueError("Expected count > 0")
    out: list[int] = []
    n = 0
    while len(out) < count:
        if is_disarium(n):
            out.append(n)
        n += 1
    return out


class DisariumExamples(unittest.TestCase):
    """Spec-based tests."""

    def test_example(self) -> None:
        self.assertTrue(is_disarium(518))


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <count>")
    count = int(args[0])
    print(", ".join(str(x) for x in disarium_numbers(count)))


if __name__ == "__main__":
    main()
