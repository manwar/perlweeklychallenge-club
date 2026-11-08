#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.divisible_average([18, 5, 7, 11]), 18)
        self.assertEqual(ch_1.divisible_average([6, 12, 18, 24, 30, 40]), 18)
        self.assertEqual(ch_1.divisible_average([3, 9, 15, 21, 27]), 0)
        self.assertEqual(ch_1.divisible_average([6, 12, 14, 20]), 9)
        self.assertEqual(ch_1.divisible_average([6, 6, 6, 12, 12]), 8)

    def test_ch_2(self):
        self.assertEqual(ch_2.string_difference(["ab", "bc", "cd", "zy"]), "zy")
        self.assertEqual(ch_2.string_difference(["cba", "fed", "azy"]), "azy")
        self.assertEqual(ch_2.string_difference(["pop", "ada", "beb", "cfc"]), "pop")
        self.assertEqual(ch_2.string_difference(["aaaa", "zzzz", "mmmm", "aaba"]), "aaba")
        self.assertEqual(ch_2.string_difference(["aceg", "bdfh", "cegi", "azbz"]), "azbz")


if __name__ == "__main__":
    unittest.main()
