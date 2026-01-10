#!/usr/bin/env python3
"""Five-number Summary - Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def quantile(sorted_data: Sequence[int], p: float) -> float:
    """Linear interpolation quantile (inclusive method)."""
    n = len(sorted_data)
    pos = p * (n - 1)
    k = int(pos)
    f = pos - k
    if f == 0:
        return sorted_data[k]
    return sorted_data[k] + f * (sorted_data[k + 1] - sorted_data[k])


def five_number_summary(
        ints: Sequence[int]) -> tuple[float, float, float, float, float]:
    """Compute the five-number summary."""
    if not ints:
        raise ValueError("Array must be non-empty")
    sorted_ints = sorted(ints)
    return (
        sorted_ints[0],
        quantile(sorted_ints, 0.25),
        quantile(sorted_ints, 0.50),
        quantile(sorted_ints, 0.75),
        sorted_ints[-1],
    )


class FiveNumberSummaryExamples(unittest.TestCase):
    """Example-based tests."""

    def test_wikipedia_example(self) -> None:
        data = [6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49]
        self.assertEqual(five_number_summary(data), (6, 25.5, 40, 42.5, 49))

    def test_even_length(self) -> None:
        data = list(range(11))
        self.assertEqual(five_number_summary(data), (0, 2.5, 5, 7.5, 10))

    def test_odd_length(self) -> None:
        self.assertEqual(five_number_summary([1, 2, 3, 4, 5]), (1, 2, 3, 4, 5))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    ints = [int(x) for x in args]
    summary = five_number_summary(ints)
    print(f"Input:  @ints = ({', '.join(map(str, ints))})")
    print(f"Output: ({', '.join(map(str, summary))})")


if __name__ == "__main__":
    main()
