#!/usr/bin/env python3
"""
Module to process a list of words by dropping consecutive anagrams.
Applies the rule iteratively:
if two consecutive words are anagrams, drop the first word.
A contiguous block of anagrams will collapse to a single word.
"""

import unittest


def sorted_word(word: str) -> str:
    return ''.join(sorted(word))


def find_anagrams(words: list[str]) -> int:
    """
    Iteratively remove the first word from any consecutive pair of anagrams.

    Args:
        words (List[str]): The list of words.

    Returns:
        int: The count of words remaining after processing.
    """
    lst = words[:]  # work on a copy
    changed = True
    while changed:
        changed = False
        for i in range(len(lst) - 1):
            if sorted_word(lst[i]) == sorted_word(lst[i + 1]):
                lst.pop(i)
                changed = True
                break  # restart from beginning
    return len(lst)


if __name__ == "__main__":

    class TestFindAnagrams(unittest.TestCase):

        def test_example1(self):
            self.assertEqual(
                find_anagrams(["acca", "dog", "god", "perl", "repl"]), 3)

        def test_example2(self):
            self.assertEqual(
                find_anagrams(["abba", "baba", "aabb", "ab", "ab"]), 2)

        def test_simple_chain(self):
            self.assertEqual(find_anagrams(["abc", "cab", "bca"]), 1)

        def test_repeating_words(self):
            self.assertEqual(find_anagrams(["word", "drow", "word", "word"]),
                             1)

    unittest.main()
