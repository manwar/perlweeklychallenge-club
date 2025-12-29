#!/usr/bin/env python3
"""3-digits Even - Perl Weekly Challenge 303 task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def three_digits_even(ints: Sequence[int]) -> list[int]:
    """Return all distinct even 3-digit integers formable from the given digits."""
    if len(ints) < 3:
        raise ValueError("Need at least 3 digits")
    if any(d < 0 or d > 9 for d in ints):
        raise ValueError("Expected digits 0..9")

    counts = Counter(ints)
    out: set[int] = set()

    for a in range(1, 10):
        if counts[a] == 0:
            continue
        counts[a] -= 1
        for b in range(10):
            if counts[b] == 0:
                continue
            counts[b] -= 1
            for c in (0, 2, 4, 6, 8):
                if counts[c] > 0:
                    out.add(100 * a + 10 * b + c)
            counts[b] += 1
        counts[a] += 1

    return sorted(out)


class ThreeDigitsEvenExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            three_digits_even((2, 1, 3, 0)),
            [102, 120, 130, 132, 210, 230, 302, 310, 312, 320],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            three_digits_even((2, 2, 8, 8, 2)),
            [222, 228, 282, 288, 822, 828, 882],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    values = [int(token) for token in args]
    result = three_digits_even(values)
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: ({', '.join(map(str, result))})")


if __name__ == "__main__":
    main()
