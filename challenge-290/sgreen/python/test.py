#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.double_exists([6, 2, 3, 3]))
        self.assertFalse(ch_1.double_exists([3, 1, 4, 13]))
        self.assertTrue(ch_1.double_exists([2, 1, 4, 2]))
        self.assertFalse(ch_1.double_exists([1, 0]))
        self.assertTrue(ch_1.double_exists([1, 0, 0]))

    def test_ch_2(self):
        self.assertTrue(ch_2.luhn_algorithm('17893729974'))
        self.assertTrue(ch_2.luhn_algorithm('4137 8947 1175 5904'))
        self.assertFalse(ch_2.luhn_algorithm('4137 8974 1175 5904'))


if __name__ == '__main__':
    unittest.main()
