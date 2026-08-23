#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.rearrange_binstr("111000"), 0)
        self.assertEqual(ch_1.rearrange_binstr("00011"), 4)
        self.assertEqual(ch_1.rearrange_binstr("01011"), 3)
        self.assertEqual(ch_1.rearrange_binstr("010101"), 3)
        self.assertEqual(ch_1.rearrange_binstr("00001"), 4)

    def test_ch_2(self):
        self.assertEqual(ch_2.atom_count("((N2O)3(H2O)2)2"), "H8N12O10")
        self.assertEqual(ch_2.atom_count("Mg3(PO4)2"), "Mg3O8P2")
        self.assertEqual(ch_2.atom_count("(((H)2)3)4"), "H24")
        self.assertEqual(ch_2.atom_count("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40")
        self.assertEqual(ch_2.atom_count("Z2Y3(X2W)2"), "W2X4Y3Z2")


if __name__ == "__main__":
    unittest.main()
