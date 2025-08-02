#!/usr/bin/env python

import unittest


def is_friendly_string(str1: str, str2: str) -> bool:
    """
    Check if swapping any two letters in str1 can match str2.

    Args:
        str1: First input string
        str2: Second input string to match against

    Returns:
        bool: True if swapping two letters in str1 can produce str2, False otherwise

    Examples:
        >>> is_friendly_string("desc", "dsec")
        True
        >>> is_friendly_string("poo", "eop")
        False
    """
    if not str1 or not str2 or len(str1) != len(str2):
        return False

    # If strings are identical, no swap needed
    if str1 == str2:
        return True

    # Find positions where strings differ
    diff_positions: list[tuple[int, str, str]] = [(i, str1[i], str2[i])
                                                  for i in range(len(str1))
                                                  if str1[i] != str2[i]]

    # If exactly two positions differ, check if swapping them works
    if len(diff_positions) == 2:
        pos1, char1, char2 = diff_positions[0]
        pos2, char3, char4 = diff_positions[1]
        return char1 == char4 and char2 == char3

    return False


class TestFriendlyStrings(unittest.TestCase):

    def test_example1(self):
        """Test case from Example 1"""
        self.assertTrue(is_friendly_string("desc", "dsec"))

    def test_example2(self):
        """Test case from Example 2"""
        self.assertTrue(is_friendly_string("fuck", "fcuk"))

    def test_example3(self):
        """Test case from Example 3"""
        self.assertFalse(is_friendly_string("poo", "eop"))

    def test_example4(self):
        """Test case from Example 4"""
        self.assertTrue(is_friendly_string("stripe", "sprite"))

    def test_empty_input(self):
        """Test with empty inputs"""
        self.assertFalse(is_friendly_string("", "test"))
        self.assertFalse(is_friendly_string("test", ""))

    def test_different_lengths(self):
        """Test with different length strings"""
        self.assertFalse(is_friendly_string("test", "testing"))

    def test_identical_strings(self):
        """Test with identical strings"""
        self.assertTrue(is_friendly_string("hello", "hello"))


if __name__ == '__main__':
    unittest.main()
