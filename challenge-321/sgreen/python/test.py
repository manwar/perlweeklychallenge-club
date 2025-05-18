#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.distinct_average([1, 2, 4, 3, 5, 6]), 1)
        self.assertEqual(ch_1.distinct_average([0, 2, 4, 8, 3, 5]), 2)
        self.assertEqual(ch_1.distinct_average([7, 3, 1, 0, 5, 9]), 2)

    def test_ch_2(self):
        self.assertTrue(ch_2.backspace_compare("ab#c", "ad#c"))
        self.assertTrue(ch_2.backspace_compare("ab##", "a#b#"))
        self.assertFalse(ch_2.backspace_compare("a#b", "c"))


if __name__ == "__main__":
    unittest.main()
