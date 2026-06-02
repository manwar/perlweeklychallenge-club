#!/usr/bin/env python3

import unittest

def same_color(c1, c2):
    sum1 = (ord(c1[0]) - ord('a')) + int(c1[1:])
    sum2 = (ord(c2[0]) - ord('a')) + int(c2[1:])

    return "true" if (sum1 % 2) == (sum2 % 2) else "false"

class TestChessboard(unittest.TestCase):
    def test_colors(self):
        examples = [
            (["a7", "f4"], "true"),
            (["c1", "a8"], "false"),
            (["b5", "h2"], "false"),
            (["f3", "h1"], "true"),
            (["a1", "g8"], "false"),
        ]

        for inputs, expected in examples:
            with self.subTest(inputs=inputs):
                self.assertEqual(same_color(*inputs), expected)

if __name__ == '__main__':
    unittest.main()
