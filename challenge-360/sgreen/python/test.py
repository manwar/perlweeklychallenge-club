#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.text_justifier("Hi", 5), "*Hi**")
        self.assertEqual(ch_1.text_justifier("Code", 10), "***Code***")
        self.assertEqual(ch_1.text_justifier("Hello", 9), "**Hello**")
        self.assertEqual(ch_1.text_justifier("Perl", 4), "Perl")
        self.assertEqual(ch_1.text_justifier("A", 7), "***A***")
        self.assertEqual(ch_1.text_justifier("", 5), "*****")

    def test_ch_2(self):
        self.assertEqual(ch_2.word_sorter("The quick brown fox"), "brown fox quick The")
        self.assertEqual(ch_2.word_sorter("Hello    World!   How   are you?"), "are Hello How World! you?")
        self.assertEqual(ch_2.word_sorter("Hello"), "Hello")
        self.assertEqual(ch_2.word_sorter("Hello, World! How are you?"), "are Hello, How World! you?")
        self.assertEqual(ch_2.word_sorter("I have 2 apples and 3 bananas!"), "2 3 and apples bananas! have I")


if __name__ == "__main__":
    unittest.main()
