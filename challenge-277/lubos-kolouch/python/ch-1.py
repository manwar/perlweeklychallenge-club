#!/usr/bin/env python3
"""Count Common - Perl Weekly Challenge 277 task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def count_common(words1: Sequence[str], words2: Sequence[str]) -> int:
    """Return count of words appearing exactly once in both arrays."""
    c1 = Counter(words1)
    c2 = Counter(words2)
    return sum(1 for word, n in c1.items() if n == 1 and c2.get(word, 0) == 1)


class CountCommonExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            count_common(("Perl", "is", "my", "friend"), ("Perl", "and", "Raku", "are", "friend")),
            2,
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            count_common(
                ("Perl", "and", "Python", "are", "very", "similar"),
                ("Python", "is", "top", "in", "guest", "languages"),
            ),
            1,
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            count_common(
                ("Perl", "is", "imperative", "Lisp", "is", "functional"),
                ("Crystal", "is", "similar", "to", "Ruby"),
            ),
            0,
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface.

    Usage: python3 ch-1.py <words1...> -- <words2...>
    """
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if "--" not in args:
        raise SystemExit("Usage: python3 ch-1.py <words1...> -- <words2...>")
    sep = args.index("--")
    if sep == 0 or sep == len(args) - 1:
        raise SystemExit("Usage: python3 ch-1.py <words1...> -- <words2...>")

    w1 = args[:sep]
    w2 = args[sep + 1 :]
    print(f"Input:  @words1 = ({', '.join(repr(x) for x in w1)})")
    print(f"        @words2 = ({', '.join(repr(x) for x in w2)})")
    print(f"Output: {count_common(w1, w2)}")


if __name__ == "__main__":
    main()

