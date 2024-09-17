#!/usr/bin/env perl

# Challenge 064
#
# TASK #2 > Word Break
# Submitted by: Mohammad S Anwar
#
# You are given a string $S and an array of words @W.
#
# Write a script to find out if $S can be split into sequence of one or more
# words as in the given @W.
#
# Print the all the words if found otherwise print 0.
#
# Example 1:
# Input:
#
# $S = "perlweeklychallenge"
# @W = ("weekly", "challenge", "perl")
#
# Output:
#
# "perl", "weekly", "challenge"
# Example 2:
# Input:
#
# $S = "perlandraku"
# @W = ("python", "ruby", "haskell")
#
# Output:
#
# 0 as none matching word found.

import itertools
import unittest

def word_break(S, *W):
    k = len(W)
    for words in itertools.permutations(W):
        if ''.join(words) == S:
            return ' '.join(W)
    return "0"

class TestWordBreak(unittest.TestCase):
    def test_word_break(self):
        self.assertEqual(word_break("perlweeklychallenge", "weekly", "challenge", "perl"),
                         "weekly challenge perl")
        self.assertEqual(word_break("perlandraku", "python", "ruby", "haskell"),
                         "0")

if __name__ == '__main__':
    unittest.main()
