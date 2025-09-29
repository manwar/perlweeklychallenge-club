#!/usr/bin/env python3
"""
Task 2: Reverse Prefix
Given a string and a character, reverses the prefix up to the first occurrence of the character.
"""

import unittest


def reverse_prefix(str_input: str, char: str) -> str:
    """
    Reverse prefix up to first occurrence of given character.

    Args:
        str_input: Input string
        char: Character to find

    Returns:
        String with prefix reversed up to first occurrence of char
    """
    # Find position of first occurrence of char
    pos = str_input.find(char)

    # If char not found, return original string
    if pos == -1:
        return str_input

    # Get prefix up to and including char
    prefix = str_input[:pos + 1]

    # Reverse prefix and append rest of string
    return prefix[::-1] + str_input[pos + 1:]


# Unit tests


class TestReversePrefix(unittest.TestCase):

    def test_example1(self):
        """Test Example 1: programming, g"""
        self.assertEqual(reverse_prefix("programming", "g"), "gorpramming")

    def test_example2(self):
        """Test Example 2: hello, h"""
        self.assertEqual(reverse_prefix("hello", "h"), "hello")

    def test_example3(self):
        """Test Example 3: abcdefghij, h"""
        self.assertEqual(reverse_prefix("abcdefghij", "h"), "hgfedcbaij")

    def test_example4(self):
        """Test Example 4: reverse, s"""
        self.assertEqual(reverse_prefix("reverse", "s"), "srevere")

    def test_example5(self):
        """Test Example 5: perl, r"""
        self.assertEqual(reverse_prefix("perl", "r"), "repl")


if __name__ == "__main__":
    unittest.main()
