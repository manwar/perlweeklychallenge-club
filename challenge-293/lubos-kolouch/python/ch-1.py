#!/usr/bin/env python3
"""Similar Dominoes - Perl Weekly Challenge 293 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def count_similar_dominos(dominos: Sequence[Sequence[int]]) -> int:
    """Return the count of dominoes that have at least one similar domino."""
    domino_counts: dict[tuple[int, int], int] = {}

    for domino in dominos:
        if len(domino) != 2:
            raise ValueError("Each domino must have exactly 2 numbers")
        a, b = domino[0], domino[1]
        key = (min(a, b), max(a, b))
        domino_counts[key] = domino_counts.get(key, 0) + 1

    count = 0
    for domino in dominos:
        a, b = domino[0], domino[1]
        key = (min(a, b), max(a, b))
        if domino_counts[key] > 1:
            count += 1

    return count


class TestSimilarDominoes(unittest.TestCase):
    """Unit tests for count_similar_dominos."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(count_similar_dominos([[1, 3], [3, 1], [2, 4], [6, 8]]), 2)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(
            count_similar_dominos([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]),
            3,
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
