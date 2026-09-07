#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.uncommon_word("apple banana apple", "banana orange"),
            ["orange"]
        )
        self.assertEqual(
            ch_1.uncommon_word("cat dog", "bird fish"),
            ["cat", "dog", "bird", "fish"]
        )
        self.assertEqual(
            ch_1.uncommon_word("the quick brown fox", "the quick"),
            ["brown", "fox"]
        )
        self.assertEqual(ch_1.uncommon_word("hello", "hello"), [])
        self.assertEqual(
            ch_1.uncommon_word("blue blue red", "red green green yellow"),
            ["yellow"]
        )

    def test_ch_2(self):
        self.assertEqual(ch_2.outermost_parentheses("()()()"), "")
        self.assertEqual(ch_2.outermost_parentheses("(((())))"), "((()))")
        self.assertEqual(ch_2.outermost_parentheses("(()())(())"), "()()()")
        self.assertEqual(ch_2.outermost_parentheses("()((()))()"), "(())")
        self.assertEqual(ch_2.outermost_parentheses("(()(()))(()())"), "()(())()()")


if __name__ == "__main__":
    unittest.main()
