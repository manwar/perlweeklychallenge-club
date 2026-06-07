#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.same_color("a7", "f4"))
        self.assertFalse(ch_1.same_color("c1", "e8"))
        self.assertFalse(ch_1.same_color("b5", "h2"))
        self.assertTrue(ch_1.same_color("f3", "h1"))
        self.assertFalse(ch_1.same_color("a1", "g8"))

    def test_ch_2(self):
        str_1 = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."
        out_1 = "web server for doubled words (such as '[this] [this]'), a common problem"

        str_2 = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."
        out_2 = "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"

        str_3 = "to make a word bold: '...it is <B>very</B> very important...'."
        out_3 = "to make a word bold: '...it is <B>[very]</B> [very] important...'."

        str_4 = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
        out_4 = ""

        str_5 = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
        out_5 = "There's more than [one] [one] way to do it."

        str_6 = "I can't can't do this"
        out_6 = "I [can't] [can't] do this"

        self.assertEqual(ch_2.doubled_words(str_1), out_1)
        self.assertEqual(ch_2.doubled_words(str_2), out_2)
        self.assertEqual(ch_2.doubled_words(str_3), out_3)
        self.assertEqual(ch_2.doubled_words(str_4), out_4)
        self.assertEqual(ch_2.doubled_words(str_5), out_5)
        self.assertEqual(ch_2.doubled_words(str_6), out_6)


if __name__ == "__main__":
    unittest.main()
