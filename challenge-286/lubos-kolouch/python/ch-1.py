#!/usr/bin/env python3
"""Self Spammer - The Weekly Challenge 286 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import os
import random
import sys
import unittest


def get_random_word(filename: str | None = None) -> str:
    """Read source code, tokenize into whitespace-delimited words, and return a random word.

    Args:
        filename: Path to the source file. If None, uses this file.

    Returns:
        A random word chosen from the script's source code.
    """
    target_path = filename if filename is not None else os.path.abspath(__file__)
    with open(target_path, encoding="utf-8") as file:
        content = file.read()
    words = content.split()
    return random.choice(words)  # nosec B311


class TestSelfSpammer(unittest.TestCase):
    """Unit tests for get_random_word."""

    def test_word_in_source(self) -> None:
        """Test that returned word is non-empty and present in the source file."""
        word = get_random_word()
        filename = os.path.abspath(__file__)
        with open(filename, encoding="utf-8") as file:
            content = file.read()
        self.assertTrue(len(word) > 0)
        self.assertIn(word, content.split(), "Word should be present in source tokens")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1 and argv[1] == "--test":
        unittest.main(argv=[sys.argv[0]])
        return
    print(get_random_word())


if __name__ == "__main__":
    main(sys.argv)
