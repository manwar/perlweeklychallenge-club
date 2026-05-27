#!/usr/bin/env python3
"""Single Common Word - Perl Weekly Challenge 375 task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def single_common_word(arr1: list[str], arr2: list[str]) -> int:
    """Return count of words appearing exactly once in each array (case-sensitive)."""
    count1 = Counter(arr1)
    count2 = Counter(arr2)

    return sum(
        1 for word, freq in count1.items() if freq == 1 and count2.get(word, 0) == 1
    )


class SingleCommonWordExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            single_common_word(
                ["apple", "banana", "cherry"], ["banana", "cherry", "date"]
            ),
            2,
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            single_common_word(["a", "ab", "abc"], ["a", "a", "ab", "abc"]), 2
        )

    def test_example_3(self) -> None:
        self.assertEqual(single_common_word(["Hello", "world"], ["hello", "world"]), 1)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
