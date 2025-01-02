#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.ones_and_zeros(["10", "0001", "111001", "1", "0"], 5, 3),
            4
        )
        self.assertEqual(ch_1.ones_and_zeros(["10", "1", "0"], 1, 1), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.step_by_step([-3, 2, -3, 4, 2]), 5)
        self.assertEqual(ch_2.step_by_step([1, 2]), 1)
        self.assertEqual(ch_2.step_by_step([1, -2, -3]), 5)


if __name__ == '__main__':
    unittest.main()
