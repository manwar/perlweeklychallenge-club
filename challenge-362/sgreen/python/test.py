#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.echo_chamber("abca"), "abbcccaaaa")
        self.assertEqual(ch_1.echo_chamber("xyz"), "xyyzzz")
        self.assertEqual(ch_1.echo_chamber("code"), "coodddeeee")
        self.assertEqual(ch_1.echo_chamber("hello"), "heelllllllooooo")
        self.assertEqual(ch_1.echo_chamber("a"), "a")

    def test_ch_2(self):
        self.assertEqual(ch_2.spellbound_sorting([6, 7, 8, 9 ,10]), [8, 9, 7, 6, 10])
        self.assertEqual(ch_2.spellbound_sorting([-3, 0, 1000, 99]), [-3, 99, 1000, 0])
        self.assertEqual(ch_2.spellbound_sorting([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2])
        self.assertEqual(ch_2.spellbound_sorting([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0])
        self.assertEqual(ch_2.spellbound_sorting([100, 101, 102]), [100, 101, 102])


if __name__ == "__main__":
    unittest.main()
