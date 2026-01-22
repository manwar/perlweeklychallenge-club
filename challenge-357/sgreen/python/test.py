#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.kaprekar_constant(3524), 3)
        self.assertEqual(ch_1.kaprekar_constant(6174), 0)
        self.assertEqual(ch_1.kaprekar_constant(9998), 5)
        self.assertEqual(ch_1.kaprekar_constant(1001), 4)
        self.assertEqual(ch_1.kaprekar_constant(9000), 4)
        self.assertEqual(ch_1.kaprekar_constant(1111), -1)

    def test_ch_2(self):
        fract_3 = ["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"]

        fract_4 = [
            "1/4", "1/3", "1/2", "2/3", "3/4", "1/1",
            "4/3", "3/2", "2/1", "3/1", "4/1"
        ]

        fract_5 = [
            "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5",
            "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1",
            "5/1"
        ]

        fract_6 = [
            "1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4",
            "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1",
            "5/2", "3/1", "4/1", "5/1", "6/1"
        ]

        self.assertEqual(ch_2.unique_fraction_generator(3), fract_3)
        self.assertEqual(ch_2.unique_fraction_generator(4), fract_4)
        self.assertEqual(ch_2.unique_fraction_generator(1), ["1/1"])
        self.assertEqual(ch_2.unique_fraction_generator(6), fract_6)
        self.assertEqual(ch_2.unique_fraction_generator(5), fract_5)


if __name__ == "__main__":
    unittest.main()
