#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.greatest_letter('PeRlwEeKLy'), 'L')
        self.assertEqual(ch_1.greatest_letter('ChaLlenge'), 'L')
        self.assertEqual(ch_1.greatest_letter('The'), None)

    def test_ch_2(self):
        self.assertEqual(ch_2.target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2])
        self.assertEqual(ch_2.target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4])
        self.assertEqual(ch_2.target_array([1], [0]), [1])


if __name__ == '__main__':
    unittest.main()
