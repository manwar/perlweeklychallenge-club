#!/usr/bin/env python3
"""Sum Bitwise Operator - Perl Weekly Challenge 163 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def bitwise_sum(values: Sequence[int]) -> int:
    """Return sum of bitwise AND over all unique pairs from unique values."""
    uniq = sorted(set(int(x) for x in values))
    total = 0
    for i in range(len(uniq)):
        for j in range(i + 1, len(uniq)):
            total += uniq[i] & uniq[j]
    return total


class SumBitwiseExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(bitwise_sum((1, 2, 3)), 3)

    def test_example_2(self) -> None:
        self.assertEqual(bitwise_sum((2, 3, 4)), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    values = [int(token) for token in args]
    print(f"Input:  @n = ({', '.join(str(x) for x in values)})")
    print(f"Output: {bitwise_sum(values)}")


if __name__ == "__main__":
    main()

