#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.missing_letter(["a", "c", "?", "g", "i"]), "e")
        self.assertEqual(ch_1.missing_letter(["a", "d", "?", "j", "m"]), "g")
        self.assertEqual(ch_1.missing_letter(["a", "e", "?", "m", "q"]), "i")
        self.assertEqual(ch_1.missing_letter(["a", "c", "f", "?", "k"]), "h")
        self.assertEqual(ch_1.missing_letter(["b", "e", "g", "?", "l"]), "j")

    def test_ch_2(self):
        self.assertEqual(ch_2.subset_equilibrium([2, 1, 4, 3]), [[2, 1], [1, 4], [2, 3], [4, 3]])
        self.assertEqual(ch_2.subset_equilibrium([3, 0, 3, 0]), [[3, 0], [3, 0, 3]])
        self.assertEqual(ch_2.subset_equilibrium([5, 1, 1, 1]), [[5, 1, 1]])
        self.assertEqual(ch_2.subset_equilibrium([3, -1, 4, 2]), [[3, -1, 4], [3, 2]])
        self.assertEqual(ch_2.subset_equilibrium([10, 20, 30, 40]), [])


if __name__ == "__main__":
    unittest.main()
