#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.largest_interval(20), 2)
        self.assertEqual(ch_1.largest_interval(110), 4)
        self.assertEqual(ch_1.largest_interval(500), 11)
        self.assertEqual(ch_1.largest_interval(2026), 105)
        self.assertEqual(ch_1.largest_interval(10000), 105)

    def test_ch_2(self):
        gene_bank_1 = ["AACCGCTA", "AAACGGTA"]
        gene_bank_2 = ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]
        gene_bank_3 = ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]
        gene_bank_4 = ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]
        gene_bank_5 = ["AACCGGTT"]

        self.assertEqual(ch_2.mgm("AACCGGTT", "AACCGGTA", gene_bank_1), -1)
        self.assertEqual(ch_2.mgm("AACCGGTT", "AACCGGAA", gene_bank_2), 2)
        self.assertEqual(ch_2.mgm("AAAAAAAA", "AAAAACCC", gene_bank_3), -1)
        self.assertEqual(ch_2.mgm("GAAAAAAA", "GCCCCCCC", gene_bank_4), 7)
        self.assertEqual(ch_2.mgm("AACCGGTT", "AACCGGTT", gene_bank_5), 0)


if __name__ == "__main__":
    unittest.main()
