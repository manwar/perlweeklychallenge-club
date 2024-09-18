#!/usr/bin/env python3

# Challenge 063
#
# TASK #1 > Last Word
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# Define sub last_word($string, $regexp) that returns the last word matching
# $regexp found in the given string, or undef if the string does not contain a
# word matching $regexp.
#
# For this challenge, a "word" is defined as any character sequence consisting
# of non-whitespace characters (\S) only. That means punctuation and other
# symbols are part of the word.
#
# The $regexp is a regular expression. Take care that the regexp can only match
# individual words! See the Examples for one way this can break if you are not
# careful.
#
# Examples
# last_word('  hello world',                qr/[ea]l/);      # 'hello'
# last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
# last_word("spaces in regexp won't match", qr/in re/);      #  undef
# last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

import re
import unittest

def last_word(text, pattern):
    words = text.split(' ')
    for word in reversed(words):
        if re.search(pattern, word, re.IGNORECASE):
            return word
    return None

class TestLastWord(unittest.TestCase):
    def test_last_word(self):
        self.assertEqual(last_word('  hello world', r'[ea]l'), 'hello')
        self.assertEqual(last_word("Don't match too much, Chet!", r'ch.t'), 'Chet!')
        self.assertIsNone(last_word("spaces in regexp won't match", r'in re'))
        self.assertEqual(last_word(' '.join(str(i) for i in range(1, int(1e6) + 1)), r'^(3.*?){3}'), '399933')

if __name__ == '__main__':
    unittest.main()
