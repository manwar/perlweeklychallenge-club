#!/usr/bin/env python3
"""Maximum Frequency - Perl Weekly Challenge 276 task 2."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def maximum_frequency(ints: Sequence[int]) -> int:
    """Return number of elements that have the highest frequency."""
    freq = Counter(ints)
    if not freq:
        return 0
    max_freq = max(freq.values())
    return sum(n for n in freq.values() if n == max_freq)


class MaximumFrequencyExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(maximum_frequency((1, 2, 2, 4, 1, 5)), 4)

    def test_example_2(self) -> None:
        self.assertEqual(maximum_frequency((1, 2, 3, 4, 5)), 5)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(str(x) for x in ints)})")
    print(f"Output: {maximum_frequency(ints)}")


if __name__ == "__main__":
    main()

