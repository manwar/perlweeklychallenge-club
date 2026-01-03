#!/usr/bin/env python3
"""Goat Latin - Perl Weekly Challenge 274 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


VOWELS = set("aeiouAEIOU")


def goat_latin(sentence: str) -> str:
    """Convert sentence to Goat Latin per the specification rules."""
    words = sentence.split()
    out: list[str] = []
    for idx, word in enumerate(words, start=1):
        if word and word[0] in VOWELS:
            transformed = word + "ma"
        else:
            transformed = word[1:] + word[0] + "ma"
        transformed += "a" * idx
        out.append(transformed)
    return " ".join(out)


class GoatLatinExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(goat_latin("I love Perl"), "Imaa ovelmaaa erlPmaaaa")

    def test_example_2(self) -> None:
        self.assertEqual(
            goat_latin("Perl and Raku are friends"),
            "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
        )

    def test_example_3(self) -> None:
        self.assertEqual(goat_latin("The Weekly Challenge"), "heTmaa eeklyWmaaa hallengeCmaaaa")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    sentence = " ".join(args)
    print(f'Input:  $sentence = "{sentence}"')
    print(f'Output: "{goat_latin(sentence)}"')


if __name__ == "__main__":
    main()

