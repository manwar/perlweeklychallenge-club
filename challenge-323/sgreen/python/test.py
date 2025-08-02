#!/usr/bin/env python3

import unittest

ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.increment_decrement(["--x", "x++", "x++"]), 1)
        self.assertEqual(ch_1.increment_decrement(["x++", "++x", "x++"]), 3)
        self.assertEqual(ch_1.increment_decrement(["x++", "++x", "--x", "x--"]), 0)

    def test_ch_2(self):
        self.assertEqual(ch_2.tax_amount(10, [[3, 50], [7, 10], [12,25]]), 2.65)
        self.assertEqual(ch_2.tax_amount(2, [[1, 0], [4, 25], [5,50]]), 0.25)
        self.assertEqual(ch_2.tax_amount(0, [[2, 50]]), 0)


if __name__ == '__main__':
    unittest.main()
