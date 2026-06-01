#!/usr/bin/env python3
"""Doubled Words - Perl Weekly Challenge 376 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def highlight_doubled_words(text: str) -> str:
    """Find doubled words, wrap them in brackets, and only return lines containing them."""
    # Matches two identical words separated by spaces and/or HTML tags.
    # Group 1: first word
    # Group 2: separator (spaces/tags)
    # Group 3: second word (captured by wrapping the \1 backreference in parens)
    pattern = re.compile(r"\b(\w+)\b(\s*(?:<[^>]*>\s*)*)\b(\1)\b", re.IGNORECASE)

    modified = pattern.sub(r"[\1]\2[\3]", text)

    # Split into lines and keep only those containing highlighted doubled words [word]
    lines = modified.split("\n")
    kept_lines = [line for line in lines if re.search(r"\[\w+\]", line)]

    return "\n".join(kept_lines)


class DoubledWordsExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            highlight_doubled_words(
                "you're given the job of checking the pages on a\n"
                "web server for doubled words (such as 'this this'), a common problem\n"
                "with documents subject to heavy editing."
            ),
            "web server for doubled words (such as '[this] [this]'), a common problem",
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            highlight_doubled_words(
                "Find doubled words despite capitalization differences, such as with 'The\n"
                "the...', as well as allow differing amounts of whitespace (spaces,\n"
                "tabs, newlines, and the like) to lie between the words."
            ),
            "Find doubled words despite capitalization differences, such as with '[The]\n"
            "[the]...', as well as allow differing amounts of whitespace (spaces,",
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            highlight_doubled_words(
                "to make a word bold: '...it is <B>very</B> very important...'."
            ),
            "to make a word bold: '...it is <B>[very]</B> [very] important...'.",
        )

    def test_example_4(self) -> None:
        self.assertEqual(
            highlight_doubled_words(
                "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
            ),
            "",
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            highlight_doubled_words(
                "There's more than one one way to do it.\n"
                "Easy things should be easy and hard things should be possible."
            ),
            "There's more than [one] [one] way to do it.",
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
