#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")
ch_2_alternate = __import__("ch-2-alternate")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.hamiltonian_cycle(32), [1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15])
        self.assertEqual(ch_1.hamiltonian_cycle(15), [])
        self.assertEqual(ch_1.hamiltonian_cycle(34), [1, 3, 13, 12, 4, 32, 17, 8, 28, 21, 15, 34, 30, 19, 6, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24])

    def test_ch_2(self):
        self.assertEqual(ch_2.replace_question_mark("01??0"), ["01000", "01010", "01100", "01110"])
        self.assertEqual(ch_2.replace_question_mark("101"), ["101"])
        self.assertEqual(ch_2.replace_question_mark("???"), ["000", "001", "010", "011", "100", "101", "110", "111"])
        self.assertEqual(ch_2.replace_question_mark("1?10"), ["1010", "1110"])
        self.assertEqual(ch_2.replace_question_mark("1?1?0"), ["10100", "10110", "11100", "11110"])

    def test_ch_2_alternate(self):
        self.assertEqual(ch_2_alternate.replace_question_mark("01??0"), ["01000", "01100", "01010", "01110"])
        self.assertEqual(ch_2_alternate.replace_question_mark("101"), ["101"])
        self.assertEqual(ch_2_alternate.replace_question_mark("???"), ["000", "100", "010", "110", "001", "101", "011", "111"])
        self.assertEqual(ch_2_alternate.replace_question_mark("1?10"), ["1010", "1110"])
        self.assertEqual(ch_2_alternate.replace_question_mark("1?1?0"), ["10100", "11100", "10110", "11110"])


if __name__ == "__main__":
    unittest.main()
