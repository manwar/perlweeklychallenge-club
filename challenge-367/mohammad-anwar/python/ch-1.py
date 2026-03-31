#!/usr/bin/env python3

import unittest

def max_odd_binary(s: str) -> str:
    c1 = s.count('1')
    c0 = s.count('0')

    return '1' * (c1 - 1) + '0' * c0 + '1'

class TestMaxOddBinary(unittest.TestCase):
    def test_examples(self):
        examples = [
            ("1011",   "1101"),
            ("100",    "001"),
            ("111000", "110001"),
            ("0101",   "1001"),
            ("1111",   "1111"),
        ]

        for input_str, expected in examples:
            with self.subTest(input_str=input_str):
                self.assertEqual(max_odd_binary(input_str), expected)

if __name__ == '__main__':
    unittest.main()
