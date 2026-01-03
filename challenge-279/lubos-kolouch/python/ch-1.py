#!/usr/bin/env python3
"""Sort Letters - Perl Weekly Challenge 279 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def sort_letters(letters: Sequence[str], weights: Sequence[int]) -> str:
    """Return letters ordered by increasing weights and joined."""
    if len(letters) != len(weights):
        raise ValueError("Expected arrays of the same length")

    idx = sorted(range(len(letters)), key=lambda i: weights[i])
    return "".join(letters[i] for i in idx)


class SortLettersExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(sort_letters(("R", "E", "P", "L"), (3, 2, 1, 4)), "PERL")

    def test_example_2(self) -> None:
        self.assertEqual(sort_letters(("A", "U", "R", "K"), (2, 4, 1, 3)), "RAKU")

    def test_example_3(self) -> None:
        self.assertEqual(
            sort_letters(("O", "H", "Y", "N", "P", "T"), (5, 4, 2, 6, 1, 3)),
            "PYTHON",
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface.

    Usage: python3 ch-1.py <letters...> -- <weights...>
    """
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if "--" not in args:
        raise SystemExit("Usage: python3 ch-1.py <letters...> -- <weights...>")
    sep = args.index("--")
    if sep == 0 or sep == len(args) - 1:
        raise SystemExit("Usage: python3 ch-1.py <letters...> -- <weights...>")

    letters = args[:sep]
    weights = [int(token) for token in args[sep + 1 :]]

    print(f"Input:  @letters = ({', '.join(repr(x) for x in letters)})")
    print(f"        @weights = ({', '.join(str(x) for x in weights)})")
    print(f"Output: {sort_letters(letters, weights)}")


if __name__ == "__main__":
    main()

