#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.word_count(
            ["unicode", "xml", "raku", "perl"]), 2)
        self.assertEqual(ch_1.word_count(["the", "weekly", "challenge"]), 2)
        self.assertEqual(ch_1.word_count(["perl", "python", "postgres"]), 0)

    def test_ch_2(self):
        self.assertEqual(ch_2.minimum_common([1, 2, 3, 4], [3, 4, 5, 6]), 3)
        self.assertEqual(ch_2.minimum_common([1, 2, 3], [2, 4]), 2)
        self.assertEqual(ch_2.minimum_common([1, 2, 3, 4], [5, 6, 7, 8]), -1)


if __name__ == '__main__':
    unittest.main()
