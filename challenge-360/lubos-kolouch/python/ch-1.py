#!/usr/bin/env python3
"""
Perl Weekly Challenge 360 - Task 1: Text Justifier

Given a string and a width, center the string within that width using '*'
characters as padding. If padding is odd, the extra '*' goes on the right.
"""

from __future__ import annotations

from typing import Sequence


def text_justifier(text: str, width: int) -> str:
    """Return `text` centered to `width` using '*' padding."""
    if width < 0:
        raise ValueError("width must be non-negative")

    if width <= len(text):
        return text

    pad = width - len(text)
    left = pad // 2
    right = pad - left
    return ("*" * left) + text + ("*" * right)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) < 1:
        raise SystemExit(f"Usage: {__file__} <width> <text>")
    width = int(argv[0])
    text = " ".join(argv[1:])
    print(text_justifier(text, width))


def _run_tests() -> None:
    import unittest

    class TestChallenge360Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(text_justifier("Hi", 5), "*Hi**")

        def test_example_2(self) -> None:
            self.assertEqual(text_justifier("Code", 10), "***Code***")

        def test_example_3(self) -> None:
            self.assertEqual(text_justifier("Hello", 9), "**Hello**")

        def test_example_4(self) -> None:
            self.assertEqual(text_justifier("Perl", 4), "Perl")

        def test_example_5(self) -> None:
            self.assertEqual(text_justifier("A", 7), "***A***")

        def test_example_6(self) -> None:
            self.assertEqual(text_justifier("", 5), "*****")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge360Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

