#!/usr/bin/env python3
"""Min Abs Diff - Perl Weekly Challenge 354 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def min_abs_diff_pairs(ints: Sequence[int]) -> list[tuple[int, int]]:
    """Return all (a, b) pairs with minimum absolute difference (a < b)."""
    if len(ints) < 2:
        return []

    sorted_ints = sorted(ints)
    min_diff = min(sorted_ints[i] - sorted_ints[i - 1] for i in range(1, len(sorted_ints)))

    return [
        (sorted_ints[i - 1], sorted_ints[i])
        for i in range(1, len(sorted_ints))
        if sorted_ints[i] - sorted_ints[i - 1] == min_diff
    ]


class MinAbsDiffExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            min_abs_diff_pairs((4, 2, 1, 3)),
            [(1, 2), (2, 3), (3, 4)],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            min_abs_diff_pairs((10, 100, 20, 30)),
            [(10, 20), (20, 30)],
        )

    def test_example_3(self) -> None:
        self.assertEqual(min_abs_diff_pairs((-5, -2, 0, 3)), [(-2, 0)])

    def test_example_4(self) -> None:
        self.assertEqual(min_abs_diff_pairs((8, 1, 15, 3)), [(1, 3)])

    def test_example_5(self) -> None:
        self.assertEqual(min_abs_diff_pairs((12, 5, 9, 1, 15)), [(9, 12), (12, 15)])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    pairs = min_abs_diff_pairs(ints)
    rendered = ", ".join(f"[{a}, {b}]" for a, b in pairs)
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {rendered}")


if __name__ == "__main__":
    main()
