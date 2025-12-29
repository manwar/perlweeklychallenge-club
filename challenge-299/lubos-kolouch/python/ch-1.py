#!/usr/bin/env python3
"""Replace Words - Perl Weekly Challenge 299 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def replace_words(words: Sequence[str], sentence: str) -> str:
    """Replace each sentence word by the shortest dictionary prefix, if any."""
    roots = sorted(words, key=len)
    out: list[str] = []
    for token in sentence.split():
        replacement = token
        for root in roots:
            if token.startswith(root):
                replacement = root
                break
        out.append(replacement)
    return " ".join(out)


class ReplaceWordsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            replace_words(("cat", "bat", "rat"), "the cattle was rattle by the battery"),
            "the cat was rat by the bat",
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            replace_words(("a", "b", "c"), "aab aac and cac bab"),
            "a a a c b",
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            replace_words(("man", "bike"), "the manager was hit by a biker"),
            "the man was hit by a bike",
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py \"word1 word2 ...\" \"sentence\"")

    words = args[0].split()
    sentence = args[1]
    print(f'Output: "{replace_words(words, sentence)}"')


if __name__ == "__main__":
    main()
