#!/usr/bin/env python3

from decimal import Decimal
import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.special_average([8000, 5000, 6000, 2000, 3000, 7000]), 5250)
        self.assertEqual(ch_1.special_average([100_000, 80_000, 110_000, 90_000]), 95_000)
        self.assertEqual(ch_1.special_average([2500, 2500, 2500, 2500]), 0)
        self.assertEqual(ch_1.special_average([2000]), 0)
        self.assertEqual(ch_1.special_average([1000, 2000, 3000, 4000, 5000, 6000]), 3500)

    def test_ch_2(self):
        self.assertTrue(ch_2.arithmetic_progression([1, 3, 5, 7, 9]))
        self.assertTrue(ch_2.arithmetic_progression([9, 1, 7, 5, 3]))
        self.assertFalse(ch_2.arithmetic_progression([1, 2, 4, 8, 16]))
        self.assertTrue(ch_2.arithmetic_progression([5, -1, 3, 1, -3]))
        self.assertTrue(ch_2.arithmetic_progression([Decimal('1.5'), 3, 0, Decimal('4.5'), 6]))
        self.assertTrue(
            ch_2.arithmetic_progression(
                [Decimal('0.1'), Decimal('0.3'), Decimal('0.2'), Decimal('0.4')]
            )
        )


if __name__ == '__main__':
    unittest.main()
