#!/usr/bin/env python3
"""Find Third - Perl Weekly Challenge 315 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def _tokenize(sentence: str) -> list[str]:
    tokens = sentence.split()
    cleaned: list[str] = []
    for token in tokens:
        token = re.sub(r"^\W+", "", token)
        token = re.sub(r"\W+$", "", token)
        if token:
            cleaned.append(token)
    return cleaned


def find_third(sentence: str, first: str, second: str) -> list[str]:
    """Return words that follow the consecutive pair (first, second)."""
    tokens = _tokenize(sentence)
    return [
        tokens[idx + 2]
        for idx in range(len(tokens) - 2)
        if tokens[idx] == first and tokens[idx + 1] == second
    ]


class FindThirdExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            find_third(
                "Perl is a my favourite language but Python is my favourite too.",
                "my",
                "favourite",
            ),
            ["language", "too"],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            find_third(
                "Barbie is a beautiful doll also also a beautiful princess.",
                "a",
                "beautiful",
            ),
            ["doll", "princess"],
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            find_third("we will we will rock you rock you.", "we", "will"),
            ["we", "rock"],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 3:
        raise SystemExit("Usage: python3 ch-2.py <sentence> <first> <second>")

    sentence, first, second = args
    result = find_third(sentence, first, second)
    quoted = '", "'.join(result)
    print(f'Input: $sentence = "{sentence}"')
    print(f'       $first = "{first}"')
    print(f'       $second = "{second}"')
    print(f'Output: ("{quoted}")')


if __name__ == "__main__":
    main()
