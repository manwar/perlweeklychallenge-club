#!/usr/bin/env python3
"""Shuffle Pairs - Perl Weekly Challenge 350 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def _signature(value: int) -> str:
    return "".join(sorted(str(value)))


def shuffle_pairs_count(from_: int, to: int, count: int) -> int:
    """
    Count integers in [from_, to] that belong to at least ``count`` shuffle pairs.

    A shuffle pair is A <= B where B = A*k for some integer k and A/B share the
    same multiset of digits.
    """
    if from_ > to:
        raise ValueError("Expected from_ <= to")
    if count < 1:
        raise ValueError("Expected count >= 1")

    witnesses: dict[int, set[int]] = {}

    for a in range(from_, to + 1):
        sig_a = _signature(a)
        digits = len(str(a))
        max_value = 10**digits - 1
        kmax = max_value // a
        if kmax < 2:
            continue

        for k in range(2, kmax + 1):
            b = a * k
            if len(str(b)) != digits:
                continue
            if _signature(b) == sig_a:
                witnesses.setdefault(a, set()).add(k)

    return sum(1 for a in range(from_, to + 1) if len(witnesses.get(a, set())) >= count)


class ShufflePairsExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(shuffle_pairs_count(1, 1000, 1), 0)

    def test_example_2(self) -> None:
        self.assertEqual(shuffle_pairs_count(1500, 2500, 1), 3)

    def test_example_3(self) -> None:
        self.assertEqual(shuffle_pairs_count(1_000_000, 1_500_000, 5), 2)

    def test_example_4(self) -> None:
        self.assertEqual(shuffle_pairs_count(13_427_000, 14_100_000, 2), 11)

    def test_example_5(self) -> None:
        self.assertEqual(shuffle_pairs_count(1030, 1130, 1), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 3:
        raise SystemExit("Usage: python3 ch-2.py <from> <to> <count>")

    from_ = int(args[0])
    to = int(args[1])
    count = int(args[2])
    result = shuffle_pairs_count(from_, to, count)
    print(f"Input: $from = {from_}, $to = {to}, $count = {count}")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
