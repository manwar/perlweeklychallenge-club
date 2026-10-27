#!/usr/bin/env python3
"""Jumble Letters - The Weekly Challenge 289 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import random
import re
import sys
import unittest


def scramble_word(word: str) -> str:
    """Scramble a word by shuffling middle letters, keeping first and last in place.

    Preserves the word capitalization style (UPPER, lower, Title, or mixed).

    Args:
        word: The word to scramble.

    Returns:
        The scrambled word.
    """
    if len(word) <= 3:
        return word

    first_letter = word[0]
    last_letter = word[-1]
    middle_letters = list(word[1:-1])

    # Scramble the middle letters
    random.shuffle(middle_letters)

    scrambled_middle = "".join(middle_letters)
    scrambled_word = first_letter + scrambled_middle + last_letter

    # Determine capitalization style
    if word.isupper():
        scrambled_word = scrambled_word.upper()
    elif word.islower():
        scrambled_word = scrambled_word.lower()
    elif word[0].isupper() and word[1:].islower():
        scrambled_word = scrambled_word.capitalize()
    else:
        # Mixed case, preserve capitalization per letter
        capitalization_pattern = [char.isupper() for char in word]
        scrambled_word = "".join(
            c.upper() if cap else c.lower()
            for c, cap in zip(scrambled_word, capitalization_pattern)
        )
    return scrambled_word


def scramble_text(text: str) -> str:
    """Scramble text by scrambling each word according to the challenge rules.

    Args:
        text: The text to scramble.

    Returns:
        The scrambled text.
    """
    tokens = re.findall(r"\w+|\s+|[^\w\s]", text, re.UNICODE)
    scrambled_tokens: list[str] = []
    for token in tokens:
        if re.match(r"^\w+$", token, re.UNICODE):
            scrambled_token = scramble_word(token)
            scrambled_tokens.append(scrambled_token)
        else:
            scrambled_tokens.append(token)
    return "".join(scrambled_tokens)


class TestScrambleWord(unittest.TestCase):
    """Unit tests for scramble_word."""

    def test_short_word(self) -> None:
        """Test short words of length <= 3."""
        self.assertEqual(scramble_word("at"), "at")
        self.assertEqual(scramble_word("the"), "the")

    def test_scramble(self) -> None:
        """Test scrambling with fixed seed."""
        random.seed(42)
        self.assertEqual(scramble_word("Perl"), "Prel")

    def test_preserve_capitalization(self) -> None:
        """Test uppercase and titlecase preservation."""
        random.seed(42)
        self.assertEqual(scramble_word("University"), "Ueritvsniy")
        self.assertEqual(scramble_word("HLELO"), "HELLO")

    def test_mixed_case(self) -> None:
        """Test mixed case preservation."""
        random.seed(42)
        self.assertEqual(scramble_word("PyThOn"), "PhToYn")


class TestScrambleText(unittest.TestCase):
    """Unit tests for scramble_text."""

    def test_text(self) -> None:
        """Test full text scrambling with fixed seed."""
        random.seed(42)
        text = "According to a research at Cambridge University."
        expected = "Acrdoncig to a raceresh at Crbimdgae Uvintrisey."
        self.assertEqual(scramble_text(text), expected)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        text = " ".join(argv[1:])
        print(scramble_text(text))
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
