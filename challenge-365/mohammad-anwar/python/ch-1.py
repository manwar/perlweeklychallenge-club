#!/usr/bin/env python3

import unittest

def alphabet_index_digit_sum(s, k):
    n = ''.join(str(ord(c) - 96) for c in s)
    for _ in range(k):
        n = str(sum(int(d) for d in n))
    return int(n)

class TestAlphabetIndexDigitSum(unittest.TestCase):
    def test_examples(self):
        examples = [
            (["abc",  1], 6),
            (["az",   2], 9),
            (["cat",  1], 6),
            (["dog",  2], 8),
            (["perl", 3], 6),
        ]

        for args, expected in examples:
            with self.subTest(args=args):
                self.assertEqual(alphabet_index_digit_sum(*args), expected)

if __name__ == '__main__':
    unittest.main()
