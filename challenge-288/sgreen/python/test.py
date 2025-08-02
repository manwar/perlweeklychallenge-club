#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.closest_palindrome(123), 121)
        self.assertEqual(ch_1.closest_palindrome(2), 1)
        self.assertEqual(ch_1.closest_palindrome(1400), 1441)
        self.assertEqual(ch_1.closest_palindrome(1001), 999)

    def test_ch_2(self):
        matrix_1 = [
            ['x', 'x', 'x', 'x', 'o'],
            ['x', 'o', 'o', 'o', 'o'],
            ['x', 'o', 'o', 'o', 'o'],
            ['x', 'x', 'x', 'o', 'o'],
        ]

        matrix_2 = [
            ['x', 'x', 'x', 'x', 'x'],
            ['x', 'o', 'o', 'o', 'o'],
            ['x', 'x', 'x', 'x', 'o'],
            ['x', 'o', 'o', 'o', 'o'],
        ]

        matrix_3 = [
            ['x', 'x', 'x', 'o', 'o'],
            ['o', 'o', 'o', 'x', 'x'],
            ['o', 'x', 'x', 'o', 'o'],
            ['o', 'o', 'o', 'x', 'x'],
        ]

        self.assertEqual(ch_2.contiguous_block(matrix_1), 11)
        self.assertEqual(ch_2.contiguous_block(matrix_2), 11)
        self.assertEqual(ch_2.contiguous_block(matrix_3), 7)


if __name__ == '__main__':
    unittest.main()
