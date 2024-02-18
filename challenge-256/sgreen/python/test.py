#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.count_pairs(["ab", "de", "ed", "bc"]), 1)
        self.assertEqual(ch_1.count_pairs(["aa", "ba", "cd", "ed"]), 0)
        self.assertEqual(ch_1.count_pairs(["uv", "qp", "st", "vu", "mn", "pq"]), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.merge_strings(["abcd", "1234"]), "a1b2c3d4")
        self.assertEqual(ch_2.merge_strings(["abc", "12345"]), "a1b2c345")
        self.assertEqual(ch_2.merge_strings(["abcde", "123"]), "a1b2c3de")


if __name__ == "__main__":
    unittest.main()
