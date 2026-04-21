#!/usr/bin/env python3

import re
import unittest
from collections import Counter

def most_popular(paragraph, banned):
    banned_set = {word.lower() for word in banned}
    words = re.findall(r'[a-z]+', paragraph.lower())
    counts = Counter(w for w in words if w not in banned_set)
    return counts.most_common(1)[0][0]

class TestMostPopular(unittest.TestCase):
    def test_example_1(self):
        para = "Bob hit a ball, the hit BALL flew far after it was hit."
        banned = ["hit"]
        self.assertEqual(most_popular(para, banned), "ball")

    def test_example_2(self):
        para = "Apple? apple! Apple, pear, orange, pear, apple, orange."
        banned = ["apple", "pear"]
        self.assertEqual(most_popular(para, banned), "orange")

    def test_example_3(self):
        para = "A. a, a! A. B. b. b."
        banned = ["b"]
        self.assertEqual(most_popular(para, banned), "a")

    def test_example_4(self):
        para = "Ball.ball,ball:apple!apple.banana"
        banned = ["ball"]
        self.assertEqual(most_popular(para, banned), "apple")

    def test_example_5(self):
        para = "The dog chased the cat, but the dog was faster than the cat."
        banned = ["the", "dog"]
        self.assertEqual(most_popular(para, banned), "cat")

if __name__ == '__main__':
    unittest.main()
