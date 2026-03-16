#!/usr/bin/env python3
"""
Valid Token Counter

Given a sentence, split into space-separated tokens and count valid words.

A token is valid if:
    - Contains no digits
    - Has at most one hyphen surrounded by lowercase letters
    - Has at most one punctuation mark (!, ., ,) appearing only at the end
"""

import re
import unittest


def valid_token_counter(sentence: str) -> int:
    """
    Count valid tokens in a sentence.

    Args:
        sentence: A string with space-separated tokens.

    Returns:
        Number of valid tokens.

    Raises:
        ValueError: If sentence is None.
    """
    if sentence is None:
        raise ValueError("sentence must not be None")

    tokens: list[str] = sentence.split()
    valid_count: int = 0

    for token in tokens:
        if _is_valid_token(token):
            valid_count += 1

    return valid_count


def _is_valid_token(token: str) -> bool:
    """
    Check if a single token is valid.

    A token is valid if:
        - Contains no digits
        - Has at most one hyphen, surrounded by lowercase letters
        - Has at most one punctuation mark (!, ., ,) at the end only

    Args:
        token: A single word/token.

    Returns:
        True if valid, False otherwise.
    """
    if re.search(r"\d", token):
        return False

    punctuation_marks = re.findall(r"[!. ,]", token)
    if len(punctuation_marks) > 1:
        return False

    punct = ""
    match = re.search(r"([!. ,])$", token)
    if match:
        punct = match.group(1)

    if punct and not re.search(r"[!. ,]$", token):
        return False

    base = token
    if punct:
        base = base[:-1]

    hyphens = base.count("-")
    if hyphens > 1:
        return False

    if hyphens == 1:
        parts = base.split("-")
        if len(parts) != 2:
            return False
        if not (re.match(r"^[a-z]+$", parts[0]) and re.match(r"^[a-z]+$", parts[1])):
            return False
        no_hyphen = base.replace("-", "")
        if re.search(r"[^a-z]", no_hyphen):
            return False
    else:
        if re.search(r"[^a-z]", base):
            return False

    return True


class TestValidTokenCounter(unittest.TestCase):
    """Unit tests for valid_token_counter function."""

    def test_example_1(self):
        """cat and dog -> 3"""
        self.assertEqual(valid_token_counter("cat and dog"), 3)

    def test_example_2(self):
        """a-b c! d,e -> 2"""
        self.assertEqual(valid_token_counter("a-b c! d,e"), 2)

    def test_example_3(self):
        """hello-world! this is fun -> 4"""
        self.assertEqual(valid_token_counter("hello-world! this is fun"), 4)

    def test_example_4(self):
        """ab- cd-ef gh- ij! -> 2"""
        self.assertEqual(valid_token_counter("ab- cd-ef gh- ij!"), 2)

    def test_example_5(self):
        """wow! a-b-c nice. -> 2"""
        self.assertEqual(valid_token_counter("wow! a-b-c nice."), 2)

    def test_single_token_valid(self):
        """Single valid token"""
        self.assertEqual(valid_token_counter("hello"), 1)

    def test_single_token_with_digit(self):
        """Token with digit is invalid"""
        self.assertEqual(valid_token_counter("hello1"), 0)

    def test_multiple_hyphens(self):
        """Multiple hyphens are invalid"""
        self.assertEqual(valid_token_counter("a-b-c"), 0)

    def test_hyphen_at_end(self):
        """Hyphen at end is invalid"""
        self.assertEqual(valid_token_counter("ab-"), 0)

    def test_hyphen_at_start(self):
        """Hyphen at start is invalid"""
        self.assertEqual(valid_token_counter("-ab"), 0)

    def test_valid_hyphen(self):
        """Valid hyphen pattern"""
        self.assertEqual(valid_token_counter("a-b"), 1)

    def test_punctuation_middle(self):
        """Punctuation in middle is invalid"""
        self.assertEqual(valid_token_counter("hel,lo"), 0)

    def test_punctuation_at_end_valid(self):
        """Punctuation at end is valid"""
        self.assertEqual(valid_token_counter("hello!"), 1)

    def test_multiple_punctuations(self):
        """Multiple punctuation marks are invalid"""
        self.assertEqual(valid_token_counter("hello!."), 0)

    def test_empty_sentence(self):
        """Empty sentence returns 0"""
        self.assertEqual(valid_token_counter(""), 0)

    def test_only_invalid_tokens(self):
        """Only invalid tokens returns 0"""
        self.assertEqual(valid_token_counter("123 abc1"), 0)


if __name__ == "__main__":
    unittest.main()
