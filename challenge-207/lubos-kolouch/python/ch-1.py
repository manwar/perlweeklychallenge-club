#!/usr/bin/env python3

import unittest
from typing import List


def is_single_row_word(word: str) -> bool:
    """Check if a word can be typed using only one row of the keyboard.

    Args:
        word (str): The word to check.

    Returns:
        bool: True if the word can be typed using only one row of the keyboard,
              False otherwise.

    """
    keyboard_rows = ['qwertyuiop', 'asdfghjkl', 'zxcvbnm']
    keyboard_map = {}
    for i in range(len(keyboard_rows)):
        for c in keyboard_rows[i]:
            keyboard_map[c] = i+1
    row = keyboard_map.get(word[0].lower(), 0)
    for c in word:
        if keyboard_map.get(c.lower(), 0) != row:
            return False
    return True


def filter_single_row_words(words: List[str]) -> List[str]:
    """Filter out the words that can be typed using only one row of the keyboard.

    Args:
        words (List[str]): The list of words to filter.

    Returns:
        List[str]: A new list containing only the words that can be typed using
                   only one row of the keyboard.

    """
    return [w for w in words if is_single_row_word(w)]

class TestSingleRowWords(unittest.TestCase):
    def test_example1(self):
        """Test the first example from the task description."""
        words = ["Hello", "Alaska", "Dad", "Peace"]
        single_row_words = filter_single_row_words(words)
        self.assertCountEqual(single_row_words, ["Alaska", "Dad"])

    def test_example2(self):
        """Test the second example from the task description."""
        words = ["OMG", "Bye"]
        single_row_words = filter_single_row_words(words)
        self.assertCountEqual(single_row_words, [])


if __name__ == '__main__':
    unittest.main()
