#!/usr/bin/env python3
"""
Task: Title Capital (Weekly Challenge 330)

Capitalise a title where words are separated by a single space. Words of
length 1 or 2 become lowercase; longer words are capitalised (first
letter uppercase, remaining letters lowercase).
"""
from __future__ import annotations

import unittest


def title_capital(title: str) -> str:
    """Apply the title capitalisation rules to the given string."""
    words = title.split(" ")
    transformed = [
        word.lower() if len(word) <= 2 else word.capitalize()
        for word in words
    ]
    return " ".join(transformed)


class TitleCapitalTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(title_capital("PERL IS gREAT"), "Perl is Great")
        self.assertEqual(title_capital("THE weekly challenge"), "The Weekly Challenge")
        self.assertEqual(title_capital("YoU ARE A stAR"), "You Are a Star")


if __name__ == "__main__":
    unittest.main()
