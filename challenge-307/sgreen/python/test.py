#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.check_order([5, 2, 4, 3, 1]), [0, 2, 3, 4])
        self.assertEqual(ch_1.check_order([1, 2, 1, 1, 3]), [1, 3])
        self.assertEqual(ch_1.check_order([3, 1, 3, 2, 3]), [0, 1, 3])

    def test_ch_2(self):
        words_1 = ["acca", "dog", "god", "perl", "repl"]
        words_2 = ["abba", "baba", "aabb", "ab", "ab"]
        words_3 = ["abba", "baba", "ab", "ab", "aabb"]

        self.assertEqual(ch_2.find_anagrams(words_1), 3)
        self.assertEqual(ch_2.find_anagrams(words_2), 2)
        self.assertEqual(ch_2.find_anagrams(words_3), 3)


if __name__ == '__main__':
    unittest.main()
