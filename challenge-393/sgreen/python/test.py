#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.pythagoras_multiplied(20), 12)
        self.assertEqual(ch_1.pythagoras_multiplied(7), 2)
        self.assertEqual(ch_1.pythagoras_multiplied(1), 0)
        self.assertEqual(ch_1.pythagoras_multiplied(15), 8)
        self.assertEqual(ch_1.pythagoras_multiplied(30), 22)

    def test_ch_2(self):
        self.assertEqual(ch_2.prime_step("hello"), 9)
        self.assertEqual(ch_2.prime_step("football"), 2)
        self.assertEqual(ch_2.prime_step("a"), 0)
        self.assertEqual(ch_2.prime_step("challenge"), 2)
        self.assertEqual(ch_2.prime_step("perl"), 2)


if __name__ == "__main__":
    unittest.main()
