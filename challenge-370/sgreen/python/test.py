#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        string_1 = "Bob hit a ball, the hit BALL flew far after it was hit."
        string_2 = "Apple? apple! Apple, pear, orange, pear, apple, orange."
        string_3 = "A. a, a! A. B. b. b."
        string_4 = "Ball.ball,ball:apple!apple.banana"
        string_5 = "The dog chased the cat, but the dog was faster than the cat."

        self.assertEqual(ch_1.popular_word(string_1, ["hit"]), "ball")
        self.assertEqual(ch_1.popular_word(string_2, ["apple", "pear"]), "orange")
        self.assertEqual(ch_1.popular_word(string_3, ["b"]), "a")
        self.assertEqual(ch_1.popular_word(string_4, ["ball"]), "apple")
        self.assertEqual(ch_1.popular_word(string_5, ["the", "dog"]), "cat")

    def test_ch_2(self):
        self.assertTrue(ch_2.scramble_string("abc", "acb"))
        self.assertTrue(ch_2.scramble_string("abcd", "cdba"))
        self.assertFalse(ch_2.scramble_string("hello", "hiiii"))
        self.assertTrue(ch_2.scramble_string("ateer", "eater"))
        self.assertFalse(ch_2.scramble_string("abcd", "bdac"))


if __name__ == "__main__":
    unittest.main()
