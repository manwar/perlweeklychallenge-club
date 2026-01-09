#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.thousand_separator(123), "123")
        self.assertEqual(ch_1.thousand_separator(1234), "1,234")
        self.assertEqual(ch_1.thousand_separator(1000000), "1,000,000")
        self.assertEqual(ch_1.thousand_separator(1), "1")
        self.assertEqual(ch_1.thousand_separator(12345), "12,345")

    def test_ch_2(self):
        self.assertFalse(ch_2.mountain_array([1, 2, 3, 4, 5]))
        self.assertTrue(ch_2.mountain_array([0, 2, 4, 6, 4, 2, 0]))
        self.assertFalse(ch_2.mountain_array([5, 4, 3, 2, 1]))
        self.assertFalse(ch_2.mountain_array([1, 3, 5, 5, 4, 2]))
        self.assertTrue(ch_2.mountain_array([1, 3, 2]))
        self.assertFalse(ch_2.mountain_array([1, 3]))


if __name__ == "__main__":
    unittest.main()
