#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.count_common(
                ["Perl", "is", "my", "friend"],
                ["Perl", "and", "Raku", "are", "friend"]),
            2)
        self.assertEqual(
            ch_1.count_common(
                ["Perl", "and", "Python", "are", "very", "similar"],
                ["Python", "is", "top", "in", "guest", "languages"]),
            1)
        self.assertEqual(
            ch_1.count_common(
                ["Perl", "is", "imperative", "Lisp", "is", "functional"],
                ["Crystal", "is", "similar", "to", "Ruby"]),
            0)

    def test_ch_2(self):
        self.assertEqual(ch_2.strong_pair([1, 2, 3, 4, 5]), 4)
        self.assertEqual(ch_2.strong_pair([5, 7, 1]), 1)


if __name__ == '__main__':
    unittest.main()
