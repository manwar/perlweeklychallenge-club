#!/usr/bin/env python

import unittest


def is_acronym(words: list[str], target: str) -> bool:
    """
    Check if the first letters of words form the target acronym.

    Args:
        words: List of words to check
        target: Target acronym to match against

    Returns:
        bool: True if first letters match target, False otherwise

    Examples:
        >>> is_acronym(["Perl", "Weekly", "Challenge"], "PWC")
        True
        >>> is_acronym(["Morning", "Good"], "MM")
        False
    """
    if not words or not target:
        return False

    acronym = ''.join(word[0] for word in words if word)
    return acronym == target


# Unit Tests


class TestAcronym(unittest.TestCase):

    def test_example1(self):
        """Test case from Example 1"""
        self.assertTrue(is_acronym(["Perl", "Weekly", "Challenge"], "PWC"))

    def test_example2(self):
        """Test case from Example 2"""
        self.assertTrue(is_acronym(["Bob", "Charlie", "Joe"], "BCJ"))

    def test_example3(self):
        """Test case from Example 3"""
        self.assertFalse(is_acronym(["Morning", "Good"], "MM"))

    def test_empty_input(self):
        """Test with empty inputs"""
        self.assertFalse(is_acronym([], "PWC"))
        self.assertFalse(is_acronym(["Perl"], ""))

    def test_single_letter_words(self):
        """Test with single letter words"""
        self.assertTrue(is_acronym(["A", "B", "C"], "ABC"))

    def test_case_sensitivity(self):
        """Test case sensitivity"""
        self.assertFalse(is_acronym(["perl", "weekly"], "PWC"))

    def test_empty_word(self):
        """Test with empty word in list"""
        self.assertFalse(is_acronym(["", "Weekly"], "PWC"))


if __name__ == '__main__':
    unittest.main()
