#!/usr/bin/env python3
"""Sort String - Perl Weekly Challenge 278 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


TOKEN_RE = re.compile(r"^(.+?)(\d+)$")


def sort_string(text: str) -> str:
    """Return the unshuffled sentence."""
    items: list[tuple[int, str]] = []
    for token in text.split():
        m = TOKEN_RE.match(token)
        if not m:
            raise ValueError(f"Invalid token: {token}")
        word, pos_str = m.group(1), m.group(2)
        items.append((int(pos_str), word))
    items.sort(key=lambda x: x[0])
    return " ".join(word for _, word in items)


class SortStringExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            sort_string("and2 Raku3 cousins5 Perl1 are4"),
            "Perl and Raku are cousins",
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            sort_string("guest6 Python1 most4 the3 popular5 is2 language7"),
            "Python is the most popular guest language",
        )

    def test_example_3(self) -> None:
        self.assertEqual(sort_string("Challenge3 The1 Weekly2"), "The Weekly Challenge")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    text = " ".join(args)
    print(f'Input:  $str = "{text}"')
    print(f'Output: "{sort_string(text)}"')


if __name__ == "__main__":
    main()

