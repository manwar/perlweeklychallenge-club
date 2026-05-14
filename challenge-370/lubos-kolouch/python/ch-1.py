#!/usr/bin/env python3
"""Popular Word - Perl Weekly Challenge 370 task 1."""

import re
from collections.abc import Sequence
import sys
import unittest


def popular_word(paragraph: str, banned: Sequence[str]) -> str:
    """Return the most frequent non-banned word in *paragraph*.

    Comparison is case-insensitive and punctuation is ignored.
    It is guaranteed that there is at least one non-banned word and the answer is unique.
    """
    banned_set = {b.lower() for b in banned}

    # Normalise: replace non-word/space with space, lower case, split
    words = re.sub(r"[^\w\s]", " ", paragraph).lower().split()

    freq: dict[str, int] = {}
    for w in words:
        if w in banned_set:
            continue
        freq[w] = freq.get(w, 0) + 1

    # It is guaranteed that there is at least one non-banned word and the answer is unique.
    return max(freq.items(), key=lambda kv: kv[1])[0]


class PopularWordExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            popular_word(
                "Bob hit a ball, the hit BALL flew far after it was hit.", ["hit"]
            ),
            "ball",
        )

    def test_example_2(self) -> None:
        self.assertEqual(popular_word("a.", []), "a")

    def test_example_3(self) -> None:
        self.assertEqual(
            popular_word("Bob. hIt, baLl", ["bob", "hit"]),
            "ball",
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <paragraph> '[banned,words]'")

    paragraph = args[0]
    banned_json = args[1]

    # Parse the banned array from JSON-like syntax
    banned_json = banned_json.strip("[]")
    banned = [w.strip().strip("'\"") for w in banned_json.split(",") if w.strip()]

    result = popular_word(paragraph, banned)
    print(f'Input: $paragraph = "{paragraph}", $banned = {banned}')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
