#!/usr/bin/env python3
"""Delete and Earn - Perl Weekly Challenge 303 task 2."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def delete_and_earn(ints: Sequence[int]) -> int:
    """
    Return the maximum points obtainable via delete-and-earn operations.

    Take all instances of a value v for v*count(v) points; then v-1 and v+1 are
    unavailable. This reduces to a DP over value space.
    """
    if not ints:
        return 0

    counts = Counter(ints)
    max_v = max(counts)

    prev2 = 0
    prev1 = 0
    for v in range(max_v + 1):
        gain = v * counts.get(v, 0)
        current = max(prev1, prev2 + gain)
        prev2, prev1 = prev1, current
    return prev1


class DeleteAndEarnExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(delete_and_earn((3, 4, 2)), 6)

    def test_example_2(self) -> None:
        self.assertEqual(delete_and_earn((2, 2, 3, 3, 3, 4)), 9)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    values = [int(token) for token in args]
    result = delete_and_earn(values)
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
