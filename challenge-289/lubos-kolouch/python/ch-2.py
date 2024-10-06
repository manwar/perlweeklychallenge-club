import random
import re
import unittest
from typing import List


def scramble_word(word: str) -> str:
    """
    Scrambles a word by shuffling its internal letters, keeping the first and last letters in place.
    Preserves the word's capitalization style.

    Args:
        word (str): The word to scramble.

    Returns:
        str: The scrambled word.
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
    """
    Scrambles the text by scrambling each word according to the rules.

    Args:
        text (str): The text to scramble.

    Returns:
        str: The scrambled text.
    """
    tokens = re.findall(r"\w+|\s+|[^\w\s]", text, re.UNICODE)
    scrambled_tokens = []
    for token in tokens:
        if re.match(r"\w+", token, re.UNICODE):
            scrambled_token = scramble_word(token)
            scrambled_tokens.append(scrambled_token)
        else:
            scrambled_tokens.append(token)
    return "".join(scrambled_tokens)


# Unit Tests
class TestScrambleWord(unittest.TestCase):
    def test_short_word(self):
        self.assertEqual(scramble_word("at"), "at")
        self.assertEqual(scramble_word("the"), "the")

    def test_scramble(self):
        random.seed(42)
        self.assertEqual(scramble_word("Perl"), "Prel")

    def test_preserve_capitalization(self):
        random.seed(42)
        self.assertEqual(scramble_word("University"), "Ueritvsniy")
        self.assertEqual(scramble_word("HLELO"), "HELLO")

    def test_mixed_case(self):
        random.seed(42)
        self.assertEqual(scramble_word("PyThOn"), "PhToYn")


class TestScrambleText(unittest.TestCase):
    def test_text(self):
        random.seed(42)
        text = "According to a research at Cambridge University."
        expected = "Acrdoncig to a raceresh at Crbimdgae Uvintrisey."
        self.assertEqual(scramble_text(text), expected)


if __name__ == "__main__":
    unittest.main()
