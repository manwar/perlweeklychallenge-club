#!/usr/bin/env python3

import unittest

def rearrange_spaces(text: str) -> str:
    total_spaces = text.count(' ')
    words        = text.split()
    word_count   = len(words)

    if word_count <= 1:
        return (words[0] if words else "") + (' ' * total_spaces)

    gap_count      = word_count - 1
    spaces_per_gap = total_spaces // gap_count
    remainder      = total_spaces % gap_count
    gap_string     = ' ' * spaces_per_gap

    return gap_string.join(words) + (' ' * remainder)

class TestRearrangeSpaces(unittest.TestCase):

    def test_single_word(self):
        self.assertEqual(rearrange_spaces("  challenge  "), "challenge    ")

    def test_perfect_distribution(self):
        self.assertEqual(rearrange_spaces("coding  is  fun"), "coding  is  fun")

    def test_with_remainder(self):
        self.assertEqual(rearrange_spaces("a b c  d"), "a b c d ")

    def test_large_gap(self):
        self.assertEqual(rearrange_spaces("  team      pwc  "), "team          pwc")

    def test_complex_remainder(self):
        self.assertEqual(rearrange_spaces("   the  weekly  challenge  "), "the    weekly    challenge ")

if __name__ == '__main__':
    unittest.main()
