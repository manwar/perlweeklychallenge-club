#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.reverse_base("101010", 2), 42)
        self.assertEqual(ch_1.reverse_base("EEADEE", 16), 15642094)
        self.assertEqual(ch_1.reverse_base("755", 8), 493)
        self.assertEqual(ch_1.reverse_base("1BRJB", 36), 2228519)
        self.assertEqual(ch_1.reverse_base("7MyqL", 64), 123456789)

    def test_ch_2(self):
        self.assertFalse(ch_2.same_rational_numbers("0.(12)", "0.(121)"))
        self.assertTrue(ch_2.same_rational_numbers("0.1(23)", "0.12(32)"))
        self.assertTrue(ch_2.same_rational_numbers("0.1(234)", "0.12(342)"))
        self.assertFalse(ch_2.same_rational_numbers("12.99(99)", "13."))
        self.assertTrue(ch_2.same_rational_numbers("0.(123)", "0.1(231)"))


if __name__ == "__main__":
    unittest.main()
