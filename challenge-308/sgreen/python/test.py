#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.count_common(
                ["perl", "weekly", "challenge"],
                ["raku", "weekly", "challenge"]
            ), 2
        )
        self.assertEqual(
            ch_1.count_common(["perl", "raku", "python"], ["python", "java"]),
            1
        )
        self.assertEqual(
            ch_1.count_common(
                ["guest", "contribution"],
                ["fun", "weekly", "challenge"]
            ), 0
        )

    def test_ch_2(self):
        self.assertEqual(ch_2.decode_xor([1, 2, 3], 1), [1, 0, 2, 1])
        self.assertEqual(ch_2.decode_xor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4])


if __name__ == '__main__':
    unittest.main()
